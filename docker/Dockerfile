FROM redis:7.2.4-alpine3.19

COPY ./configs/custom_redis-7.2.4-v2.conf /usr/local/etc/redis/redis.conf

RUN chown redis:redis /usr/local/etc/redis/redis.conf
RUN chmod 0640 /usr/local/etc/redis/redis.conf

USER redis

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]