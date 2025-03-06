FROM redis:7.2.4-alpine3.19

COPY ./configs/custom_redis-7.2.4-v0.conf /usr/local/etc/redis/redis.conf

RUN chown redis:redis /usr/local/etc/redis/redis.conf
RUN chmod 0640 /usr/local/etc/redis/redis.conf

#RUN mkdir -p /var/lib/redis
#RUN chown redis:redis /var/lib/redis
#
#RUN mkdir -p /var/log/redis
#RUN chown redis:redis /var/log/redis

USER redis

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]