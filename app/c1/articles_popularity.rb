require_relative('../redis_base.rb')

class ArticlesPopularity
  include RedisClientBase

  def initialize
    open_connection
  end

  def setup
    @client.set('article:12345:headline', 'Google Wants')
    @client.set('article:10001:headline', 'Millennials age')
    @client.set('article:60056:headline', 'Dark Queen')
  end

  def up_vote(id)
    key = "article:#{id}:votes"
    @client.incr(key)
  end

  def down_vote(id)
    key = "article:#{id}:votes"
    @client.decr(key)
  end

  def show_results(id)
    head_key = "article:#{id}:headline"
    vote_key = "article:#{id}:votes"
    @client.mget(head_key, vote_key) do |values|
      puts("The article #{values[0]} has votes: #{values[1]}")
    end
  end
end

ap = ArticlesPopularity.new
ap.setup
ap.up_vote(12345)
ap.up_vote(12345)
ap.up_vote(12345)
ap.up_vote(10001)
ap.up_vote(10001)
ap.down_vote(10001)
ap.up_vote(60056)

ap.show_results(12345)
ap.show_results(10001)
ap.show_results(60056)

ap.close_connection