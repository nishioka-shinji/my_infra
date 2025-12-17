FROM ruby:3.4.8-alpine

RUN apk add --no-cache \
    ca-certificates \
    tzdata

WORKDIR /app

COPY weather_bot.rb .
COPY weather_bot_runner.rb .

ENV TZ=Asia/Tokyo

RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

RUN chown -R appuser:appgroup /app

USER appuser

CMD ["ruby", "weather_bot_runner.rb"]