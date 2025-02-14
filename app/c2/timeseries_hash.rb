require_relative('../redis_client_base')

# Provo a mettere tutto in una sola hash.
# Che al massimo dura una ora.
class TimeseriesHash < RedisClientBase

  def initialize(namespace)
    @namespace = namespace
    super()
  end

  def insert(timestamp_in_seconds)
    key = key_name
    @client.hincrby(key, timestamp_in_seconds, 1)

    one_hour_in_seconds = 1 * 60 * 60
    @client.expire(key, one_hour_in_seconds)
  end

  def fetch
    @client.hgetall(key_name).each do |second, count|
      puts("At second #{second} the visits was: #{count}")
    end
  end

  def key_name
    "#{@namespace}:second"
  end
end

th = TimeseriesHash.new('money')
1.times { th.insert(0) }
3.times { th.insert(1) }
1.times { th.insert(2) }
4.times { th.insert(3) }
5.times { th.insert(4) }
7.times { th.insert(5) }
1.times { th.insert(6) }
2.times { th.insert(7) }
0.times { th.insert(8) }
0.times { th.insert(9) }
9.times { th.insert(10) }
3.times { th.insert(11) }

th.fetch
th.close_connection
