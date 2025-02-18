require_relative('../redis_client_base.rb')

class Pipeline < RedisClientBase
  def initialize
    super()
  end

  def execute
    result = @client.pipelined do |pipeline|
      pipeline.sadd("cards:suits", "hearts")
      pipeline.sadd("cards:suits", "spades")
      pipeline.sadd("cards:suits", "diamonds")
      pipeline.sadd("cards:suits", "clubs")
      pipeline.smembers("cards:suits")
    end

    puts result
  end
end


p = Pipeline.new
p.execute
p.close_connection