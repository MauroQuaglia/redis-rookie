require_relative('../redis_client_base.rb')

class BenchmarkBitmap < RedisClientBase
  USERS = 1000
  DEALS_PER_USER = 12
  MAX_DEAL_ID = 10000

  def initialize
    super()
  end

  def setup
    1.upto(USERS) do |n|
      1.upto(DEALS_PER_USER) do |m|
        @client.setbit("bitmap:user:#{n}", MAX_DEAL_ID - m, 1)
      end
    end
  end

  def memory_info
    puts("used_memory_human: #{@client.info('memory')['used_memory_human']}")
  end
end

bb = BenchmarkBitmap.new
bb.memory_info
bb.setup
bb.memory_info