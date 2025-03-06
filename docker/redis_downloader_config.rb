require('redis')

class RedisDownloaderConfig
  def initialize
    @client = Redis.new(host: 'docker-redis7-1', port: 26379)
  end

  def config_get_all
    @client.config(:get, '*')
  end
end

puts RedisDownloaderConfig.new.config_get_all