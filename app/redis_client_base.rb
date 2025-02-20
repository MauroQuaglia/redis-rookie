require('redis')

class RedisClientBase
  def initialize
    @client = Redis.new(host: '192.168.56.11', port: 6379, password: 'foobar')
    delete_all
  end

  def close_connection
    @client.close
  end

  def delete_all
    @client.flushall
  end
end