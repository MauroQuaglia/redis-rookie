require_relative('redis_base')

class RedisQueue < RedisClientBase
end

Queue.new.close