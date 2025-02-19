# redis-rookie

REDIS = REmote DIctionary Server
Redis è a thread singolo quindi viene eseguito un solocomando alla volta. Non ci possono essere race condition.

* Doc online: https://redis.io/docs/latest/
* Download example: https://github.com/redis-essentials/book
* Google: https://www.google.it/books/edition/Redis_Essentials/08WGCgAAQBAJ?hl=en&gbpv=1
* Sets: https://thoughtbot.com/blog/redis-set-intersection-using-sets-to-filter-data
* Tutti i comandi di Redis: https://redis.io/docs/latest/commands/

Redis -> DB in memoria
* NoSQL - Not only SQL
* Può essere usato come sistema di cache.

PostgreSQL -> SD su disco
da 23 a 27 compreso non ci sono


Attenzione quindi
Non è detto che il bitmap sia sempre meglio, per esempio se guardiamoi c6/benchmark nel caso considerato il bitmap usa più memoria.
C'è sempre da valutare caso per caso.
Nel caso di Redis il valore cat /proc/sys/vm/swappiness dovrebe essere messo a 0 o a 1 per fare in modo che non venga utilizzata 
la memoria swap che rallenta molto redis.
Anche  overcommit_memory = 1 se ci sono strategie per persistere i dati è molto importante impostarlo.
Anche maxmemory sarebbe da impostare, con poi un check sulla memoria effettivamentein uso.