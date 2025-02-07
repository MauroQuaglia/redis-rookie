require('redis')

client = Redis.new(host: '192.168.56.11', port: 6379)

client.set('hw', 'Hello World using Ruby and Redis!')
puts client.get('hw')

client.close