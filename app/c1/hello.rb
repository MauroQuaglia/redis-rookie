require_relative('../base.rb')

class Hello < RedisClientBase
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
hello.close