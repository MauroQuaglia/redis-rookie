require('redis')

class RedisClientBase
  def initialize
    @client = Redis.new(host: '192.168.56.11', port: 6379)
  end

  def close
    @client.close
  end
end