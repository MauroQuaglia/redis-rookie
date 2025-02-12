require_relative('../redis_client_base.rb')

class DealMetrics < RedisClientBase
  def mark_deal_as_sent(deal_id, user_id)
    @client.sadd(deal_id, user_id)
  end

  def send_deal_if_not_set(deal_id, user_id)
    result = @client.sismember(deal_id, user_id)
    if result
      puts("Deal #{deal_id} war already sent to #{user_id}.")
    else
      # Invio dell'e-mail...
      puts("Sending #{deal_id} to #{user_id}...")
      mark_deal_as_sent(deal_id, user_id)
    end
  end

  def show_users_that_receive_all_deals(deal_ids)
    puts("#{@client.sinter(deal_ids)} received all of the deals: #{deal_ids}.")
  end

  def show_user_that_receive_at_least_one_of_the_deals(deal_ids)
    puts("#{@client.sunion(deal_ids)} received at least on of the deals: #{deal_ids}.")
  end

end

dm = DealMetrics.new
dm.mark_deal_as_sent('deal:1', 'user:1')
dm.mark_deal_as_sent('deal:1', 'user:2')
dm.mark_deal_as_sent('deal:2', 'user:1')
dm.mark_deal_as_sent('deal:2', 'user:3')

dm.send_deal_if_not_set('deal:1', 'user:1') # already sent
dm.send_deal_if_not_set('deal:1', 'user:2') # already sent
dm.send_deal_if_not_set('deal:1', 'user:3') # to send

dm.show_users_that_receive_all_deals(%w[deal:1 deal:2]) # user:1, user:3
dm.show_user_that_receive_at_least_one_of_the_deals(%w[deal:1 deal:2]) # user:1, user:2, user:3

dm.close_connection