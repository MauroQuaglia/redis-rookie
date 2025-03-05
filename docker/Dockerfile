FROM redis:7.2.4-alpine3.19

COPY custom_redis-7.2.4.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]