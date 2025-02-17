require_relative('../redis_client_base.rb')

class Publisher < RedisClientBase
  def initialize
    super()
  end

  def publish(channel, command)
    @client.publish(channel, command)
    puts("Published command #{command} on channel #{channel}...")
  end
end

channel = ARGV[0]
command = ARGV[1]

p = Publisher.new
p.publish(channel, command)
p.close_connection