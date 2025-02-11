require_relative('redis_base')

# Sfruttiamo il tipo LIST di Redis per implementare una coda.
class RedisQueue
  include RedisClientBase

  def initialize(name)
    @name = "queues:#{name}"
    open_connection
  end

  def size
    @client.llen(@name)
  end

  def push(data)
    @client.lpush(@name, data)
  end

  def pop
    @client.brpop(@name)
    #@client.brpop # Serve per quando la lista è vuota, così riame in attesa... invece di rpop
    # blocking version di rpop
  end

end

# Test
=begin
queue = RedisQueue.new('logs')
queue.size
queue.push('eccolo 1')
queue.push('eccolo 2')
queue.size
queue.pop
queue.pop
queue.pop
queue.close_connection
=end
