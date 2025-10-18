require 'net/http'
require 'json'
require 'time'
require 'uri'
require 'logger'

class WeatherBot
  def self.execute
    new.execute
  end

  def initialize
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO
    @slack_token = ENV['SLACK_APP_TOKEN']
    @owm_api_key = ENV['OWM_API_KEY']
    @geo_id = ENV.fetch('GEO_ID', '1860704').to_i
    @bot_name = ENV.fetch('BOT_USER_NAME', '本日の加古川市のお天気')
    @channel = ENV.fetch('SLACK_CHANNEL', 'C03167KR265')
    @timezone_offset = ENV.fetch('TIMEZONE_OFFSET', '9').to_i
    @forecast_hours = ENV.fetch('FORECAST_HOURS', '8').to_i

    validate_configuration
  end

  private_class_method :new

  def execute
    @logger.info("Starting weather bot for geo_id: #{@geo_id}")
    weather = open_weather_map
    message = build_message(weather)
    post_to_slack(message)
    @logger.info("Weather message posted successfully")
  rescue => e
    @logger.error("Failed to execute weather bot: #{e.message}")
    raise
  end

  private

  def validate_configuration
    raise 'SLACK_APP_TOKEN is required' unless @slack_token
    raise 'OWM_API_KEY is required' unless @owm_api_key
  end

  def build_message(weather_data)
    header = "おはようございます:sunrise:\n本日のお天気はこちらです:man-tipping-hand:\n\n------------------------------\n\n"
    weather_info = weather_message(weather_data)
    footer = "------------------------------\n\n今日も1日頑張りましょう:muscle:"

    header + weather_info + footer
  end

  def open_weather_map
    uri = URI('https://api.openweathermap.org/data/2.5/forecast')
    params = {
      id: @geo_id,
      lang: 'ja',
      units: 'metric',
      appid: @owm_api_key
    }
    uri.query = URI.encode_www_form(params)

    begin
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 30) do |http|
        http.request(Net::HTTP::Get.new(uri))
      end

      raise "OpenWeatherMap error: #{res.code} #{res.body}" unless res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    rescue Net::TimeoutError => e
      @logger.error("Request timeout: #{e.message}")
      raise
    rescue JSON::ParserError => e
      @logger.error("Invalid JSON response: #{e.message}")
      raise
    rescue => e
      @logger.error("Unexpected error: #{e.message}")
      raise
    end
  end

  def weather_message(dic)
    list = dic['list']
    return '' if list.nil? || list.empty?

    list.first(@forecast_hours).map do |item|
      build_single_forecast(item)
    end.join("\n") + "\n\n"
  end

  def build_single_forecast(item)
    dt = Time.parse(item['dt_txt']) + (@timezone_offset * 60 * 60) # JST
    dt_jst_txt = dt.strftime('%m月%d日%H時')

    icon = item.dig('weather', 0, 'icon')
    emoji = weather_emoji(icon)

    temp = item.dig('main', 'temp')
    feels_like = item.dig('main', 'feels_like')

    "#{dt_jst_txt} #{emoji} 気温#{temp}度 体感気温#{feels_like}度"
  end

  def weather_emoji(code)
    map = {
      '01d' => ':sunny:',
      '02d' => ':barely_sunny:',
      '03d' => ':cloud:',
      '04d' => ':cloud:',
      '09d' => ':rain_cloud:',
      '10d' => ':sun_behind_rain_cloud:',
      '11d' => ':thunder_cloud_and_rain:',
      '13d' => ':snow_cloud:',
      '50d' => ':fog:',
      '01n' => ':sunny:',
      '02n' => ':barely_sunny:',
      '03n' => ':cloud:',
      '04n' => ':cloud:',
      '09n' => ':rain_cloud:',
      '10n' => ':sun_behind_rain_cloud:',
      '11n' => ':thunder_cloud_and_rain:',
      '13n' => ':snow_cloud:',
      '50n' => ':fog:'
    }
    map[code] || ':question:'
  end

  def post_to_slack(text)
    uri = URI.parse("https://slack.com/api/chat.postMessage")
    payload = {
      channel: @channel,
      text: text,
      username: @bot_name,
      icon_emoji: ':sunny:'
    }.to_json

    req = Net::HTTP::Post.new(uri)
    req['Content-Type'] = 'application/json'
    req['Authorization'] = "Bearer #{@slack_token}"
    req.body = payload

    begin
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', read_timeout: 30) do |http|
        http.request(req)
      end

      unless res.is_a?(Net::HTTPSuccess)
        @logger.error("Slack API error: #{res.code} #{res.body}")
        raise "Slack API error: #{res.code}"
      end

      @logger.info("Message posted to Slack successfully")
    rescue Net::TimeoutError => e
      @logger.error("Slack request timeout: #{e.message}")
      raise
    rescue => e
      @logger.error("Failed to post to Slack: #{e.message}")
      raise
    end
  end
end
