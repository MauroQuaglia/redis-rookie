require_relative('../redis_client_base.rb')

class BenchmarkSet < RedisClientBase
  USERS = 1000
  DEALS_PER_USER = 12
  MAX_DEAL_ID = 10000

  def initialize
    super()
  end

  def setup
    1.upto(USERS) do |n|
      1.upto(DEALS_PER_USER) do |m|
        @client.sadd("set:user:#{n}", MAX_DEAL_ID - m)
      end
    end
  end

  def memory_info
    puts("used_memory_human: #{@client.info('memory')['used_memory_human']}")
  end
end

bs = BenchmarkSet.new
bs.memory_info
bs.setup
bs.memory_info