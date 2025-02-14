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
  end

  def show_user_ids_from_visit(date)
    key = "visits:daily:#{date}"
    ids = []
    start = 0
    while (start >= 0)
      id = @client.bitpos(key, 1, start, -1, scale: 'BIT')
      if id != -1
        ids << id
        start = id + 1
      else
        break
      end
    end
    puts("Users #{ids.join(',')} visited on #{date}")
  end
end

mb = MetricsBitmap.new
mb.store_daily_visit('2015-01-01', '1')
mb.store_daily_visit('2015-01-01', '2')
mb.store_daily_visit('2015-01-01', '10')
mb.store_daily_visit('2015-01-01', '55')

mb.count_visits('2015-01-01')
mb.show_user_ids_from_visit('2015-01-01')
mb.close_connection