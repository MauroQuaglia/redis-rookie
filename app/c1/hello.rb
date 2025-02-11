require_relative('../redis_base.rb')

class Hello
  include RedisClientBase

  def initialize
    open_connection
  end

  def write(message)
    @client.set('hw', message)
  end

  def read
    puts(@client.get('hw'))
  end
end

hello = Hello.new
hello.write("Hello World using Ruby and Redis!")
hello.read
hello.close_connection