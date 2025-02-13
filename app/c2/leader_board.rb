require_relative('../redis_client_base.rb')

class LeaderBoard < RedisClientBase

  def initialize(name)
    @name = name
    super()
  end

  def add_user(username, score)
    @client.zadd(@name, score, username)
    puts("User #{username} added with score #{score}!")
  end

  def remove_user(username)
    @client.zrem(@name, username)
    puts("User #{username} removed!")
  end

  def get_user_score_and_rank(username)
    score = @client.zscore(@name, username)
    rank = @client.zrevrank(@name, username) + 1
    puts("User #{username}: score = #{score}, rank = #{rank}")
  end

  def show_top_users(number)
    users = @client.zrevrange(@name, 0, number - 1, withscores: true)
    puts '--- Top users ---'
    users.each do |user|
      puts user.inspect
    end
  end

  def get_users_around_user(username)
    user_rank = @client.zrevrank(@name, username)
    start_index = user_rank.zero? ? 0 : user_rank - 1
    end_index = user_rank + 1

    users = @client.zrevrange(@name, start_index, end_index, withscores: true)
    puts "--- Around #{username} ---"
    users.each do |user|
      puts user.inspect
    end
  end
end

lb = LeaderBoard.new('game-score')
lb.add_user("MQ", 10)
lb.add_user("MA", 20)
lb.add_user("ML", 30)
lb.add_user("SS", 40)
lb.add_user("MG", 50)
lb.add_user("TC", 60)

lb.get_user_score_and_rank('MQ')
lb.get_user_score_and_rank('MG')

lb.show_top_users(3)

lb.get_users_around_user('MQ')
lb.get_users_around_user('MA')
lb.get_users_around_user('TC')

lb.close_connection