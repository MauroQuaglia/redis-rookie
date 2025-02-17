require_relative('../redis_client_base.rb')

class IntroLua < RedisClientBase
  def initialize
    super()
  end

  def setup
    @client.set("my_key", "my_value")
  end

  def evalua
    # LUA parte a contare da 1, non da 0.
    lua_script = 'return redis.call("GET", KEYS[1])'
    puts @client.eval(lua_script, keys: ["my_key"])
  end
end

il = IntroLua.new
il.setup
il.evalua
il.close_connection