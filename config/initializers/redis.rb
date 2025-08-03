# config/initializers/redis.rb
require "redis"

class RedisClient
  def self.instance
    @redis ||= Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"))
  end
end
