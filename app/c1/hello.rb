require_relative('../redis_client_base.rb')

class Hello < RedisClientBase
  def write(message)
    @client.set('hw', message)
  end

  def read
    @client.get('hw')
  end
end

hello = Hello.new
hello.write("Hello World using Ruby and Redis!")
puts(hello.read)
hello.close_connection