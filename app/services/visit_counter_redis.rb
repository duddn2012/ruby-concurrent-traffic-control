class VisitCounterRedis
  REDIS_KEY = "visit_counter".freeze

  class << self
    def next_count
      RedisClient.instance.incr(REDIS_KEY)
    end

    def current_count
      RedisClient.instance.get(REDIS_KEY).to_i
    end

    def set_count(value)
      RedisClient.instance.set(REDIS_KEY, value)
    end
  end
end
