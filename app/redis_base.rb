require('redis')

module RedisClientBase
  def open_connection
    @client = Redis.new(host: '192.168.56.11', port: 6379)
  end

  def close_connection
    @client.close
  end
end