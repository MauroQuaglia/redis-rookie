require_relative('../redis_client_base.rb')

class HashVotingSystem < RedisClientBase
  def setup(id, author, title, link)
    hash_name = "link:#{id}"
    @client.hmset(
      hash_name,
      "author", author,
      "title", title,
      "link", link,
      "score", 0
    )
  end

  def up_vote(id)
    hash_name = "link:#{id}"
    @client.hincrby(hash_name, "score", 1)
  end

  def down_vote(id)
    hash_name = "link:#{id}"
    @client.hincrby(hash_name, "score", -1)
  end

  def show_results(id)
    hash_name = "link:#{id}"
    @client.hgetall(hash_name)
  end
end

hvs = HashVotingSystem.new
hvs.setup(123, "GAuthor", "Google book", "https://www.google.it/")
hvs.setup(456, "FAuthor", "Firefox book", "https://www.mozilla.org/it/firefox/")
hvs.up_vote(123)
hvs.up_vote(123)
hvs.up_vote(456)
hvs.up_vote(456)
hvs.down_vote(456)
puts hvs.show_results(123)
puts hvs.show_results(456)
hvs.close_connection