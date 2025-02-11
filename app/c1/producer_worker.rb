require_relative('../redis_queue.rb')

class ProducerWorker < RedisQueue
  def initialize(name)
    super(name)
  end

  def setup
    5.times do |i|
      push("Hello world #{i}")
    end
  end
end

producer_worker = ProducerWorker.new('logs')
producer_worker.setup
producer_worker.size
producer_worker.close_connection
