require_relative('redis_client_base')

# Sfruttiamo il tipo LIST di Redis per implementare una coda.
class RedisQueue < RedisClientBase
  def initialize(name)
    @name = "queues:#{name}"
    super()
  end

  def size
    @client.llen(@name)
  end

  def push(data)
    @client.lpush(@name, data)
  end

  def pop
    # blocking version di rpop. Serve per rimanere in attesa quando la lista è vuota.
    @client.brpop(@name)
  end
end

# Test
# queue = RedisQueue.new('logs')
# puts queue.size
# queue.push('eccolo 1')
# queue.push('eccolo 2')
# puts queue.size
# puts queue.pop
# puts queue.pop
# queue.close_connection
