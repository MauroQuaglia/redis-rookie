require_relative('../redis_queue.rb')

class ConsumerWorker < RedisQueue
  def initialize(name)
    super(name)
  end

  def messages
    loop do
      puts("message: #{pop}")
      puts("left: #{size}")
    end
  end
end

consumer_worker = ConsumerWorker.new('logs')
consumer_worker.messages