require_relative('../redis_client_base')

# Quanti utenti unici hanno visitato per ogni secondo.
class TimeseriesSortedSet < RedisClientBase

  def initialize(namespace)
    @namespace = namespace
    super()
  end

  def insert(timestamp_in_seconds, user)
    key = key_name(timestamp_in_seconds)
    @client.zincrby(key, 1, user)

    one_hour_in_seconds = 1 * 60 * 60
    @client.expire(key, one_hour_in_seconds)
  end

  def fetch(start_second, end_second)
    range = (start_second..end_second).to_a
    range.each do |second|
      key = key_name(second)
      count = @client.zcard(key)
      puts("At second #{second} the unique visits was: #{count}")
    end
  end

  def key_name(timestamp_in_seconds)
    "#{@namespace}:second:#{timestamp_in_seconds}"
  end
end

tss = TimeseriesSortedSet.new('money')
1.times { tss.insert(0, 'MQ') }
3.times { tss.insert(1, 'SS') }
2.times { tss.insert(1, 'MQ') }
1.times { tss.insert(2, 'MA') }
4.times { tss.insert(2, 'SS') }
4.times { tss.insert(2, 'TC') }
3.times { tss.insert(3, 'SS') }
5.times { tss.insert(4, 'SS') }
1.times { tss.insert(5, 'SS') }
1.times { tss.insert(6, 'SS') }
1.times { tss.insert(6, 'TC') }

tss.fetch(0,6)
tss.close_connection
