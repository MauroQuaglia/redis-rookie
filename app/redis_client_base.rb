require('redis')

class RedisClientBase
  def initialize(sentinel: true)
    @client = sentinel ? client_with_sentinel : client_without_sentinel
    delete_all
  end

  def close_connection
    @client.close
  end

  def delete_all
    @client.flushall
  end

  private

  def client_with_sentinel
    sentinels = [{ host: "192.168.56.11", port: 26379 }]

    @client = Redis.new(
      sentinels: sentinels,
      role: :master,
      password: 'foobar',
      name: "mymaster"
    )
    # Viene chiamato Sentinel che gli ritorna come chiamare Redis!
    # raise @client.inspect è illuminante: <Redis client v5.4.0 for redis://127.0.0.1:6379> (RuntimeError)
    # Quindi devo aprire da Vagrant la porta 6379 altrimenti non lo contatterò mai!
  end

  def client_without_sentinel
    Redis.new(
      host: '192.168.56.11',
      port: 6379,
      password: 'foobar')
  end
end