require('redis')

class RedisDownloaderConfig
  def initialize
    @client = Redis.new(host: 'localhost', port: 6379)
  end

  def config_get_all
    @client.config(:get, '*').sort_by { |key, _| key }.to_h
  end
end

puts RedisDownloaderConfig.new.config_get_all