require_relative('../redis_client_base.rb')

class MetricsBitmap < RedisClientBase

  def store_daily_visit(date, user_id)
    key = "visits:daily:#{date}"
    @client.setbit(key, user_id, 1)
    puts("User #{user_id} visited on #{date}")
  end

  def count_visits(date)
    key = "visits:daily:#{date}"
    count = @client.bitcount(key)
    puts("#{date} had #{count} visits.")
    #bitpos mauro 1 0 -1 BIT
    @client.bitpos()
  end
end

mb = MetricsBitmap.new

mb.close_connection