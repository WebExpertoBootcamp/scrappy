require 'redis'
redis = Redis.new(host: ENV['REDIS_HOST'] || "redis", port: ENV['REDIS_PORT'] || 6379)
puts redis.ping