require('redis')

redis = Redis.new(host: '192.168.56.11', port: 6379)
redis.set('pippo', 'super-pippo')