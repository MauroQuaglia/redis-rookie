require_relative('../redis_client_base.rb')

class UniqueVisitors < RedisClientBase

  def add_visit(date, user)
    key = "visits:#{date}"
    @client.pfadd(key, user)
  end

  def count(dates)
    keys = dates.map { |date| "visits:#{date}" }
    total = @client.pfcount(keys)
    puts("Dates #{keys.join(', ')} had #{total} visits")
  end

  def aggregate_date(date)
    keys = []
    23.times { |i| keys << "visits:#{date}T#{i}" }
    @client.pfmerge("visits:#{date}", keys)
    puts("Aggregated date for #{date}")
  end

end

uv = UniqueVisitors.new
uv.add_visit('2015-01-01T0', 'MQ')
uv.add_visit('2015-01-01T0', 'MG')
uv.add_visit('2015-01-01T2', 'SS')
uv.add_visit('2015-01-01T3', 'ML')
uv.add_visit('2015-01-01T20', 'MA')
uv.add_visit('2015-01-01T21', 'TC')

uv.count(['2015-01-01T0'])
uv.count(%w[2015-01-01T0 2015-01-01T1 2015-01-01T2])
uv.aggregate_date('2015-01-01')
uv.count(['2015-01-01'])
uv.close_connection