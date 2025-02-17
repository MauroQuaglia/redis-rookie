require_relative('../redis_client_base')

class TimeseriesString < RedisClientBase

  def initialize(namespace)
    @namespace = namespace
    super()
  end

  def insert(timestamp_in_seconds)
    key = key_name(timestamp_in_seconds)
    @client.incr(key)

    one_hour_in_seconds = 1 * 60 * 60
    @client.expire(key, one_hour_in_seconds)
  end

  def fetch(start_second, end_second)
    seconds = (start_second..end_second).to_a
    keys = seconds.map { |second| key_name(second) }

    keys.each do|key|
      total = @client.get(key)
      value = total.nil? ? 0 : total
      puts("At #{key} the visits was: #{value}")
    end
  end

  def key_name(timestamp_in_seconds)
    "#{@namespace}:second:#{timestamp_in_seconds}"
  end
end

ts = TimeseriesString.new('money')
1.times { ts.insert(0) }
3.times { ts.insert(1) }
1.times { ts.insert(2) }
4.times { ts.insert(3) }
5.times { ts.insert(4) }
7.times { ts.insert(5) }
1.times { ts.insert(6) }
2.times { ts.insert(7) }
0.times { ts.insert(8) }
0.times { ts.insert(9) }
9.times { ts.insert(10) }
3.times { ts.insert(11) }

ts.fetch(1, 10)
ts.close_connection
