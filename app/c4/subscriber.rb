require_relative('../redis_client_base.rb')

class Subscriber < RedisClientBase
  def initialize
    super()
  end

  def subscribe(*channels)
    @client.subscribe(channels) do |on|
      on.message { |channel, message| puts "Messaggio #{message} su canale #{channel}" }
    end
  end
end

channel = ARGV[0]

s = Subscriber.new
s.subscribe('global', channel)
s.close_connection