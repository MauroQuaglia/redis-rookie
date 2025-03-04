# Redis Cluster
* Proviamo a costruire un Redis Cluster a mano:
* Mi devo collegare sulla macchina Vagrant con tre tab differenti e creare i master:

* Cluster con 3 master:
```
redis-server --port 5000 --cluster-enabled yes --cluster-config-file nodes-5000.conf --cluster-node-timeout 2000
--cluster-slave-validity-factor 10 --cluster-migration-barrier 1 --cluster-require-full-coverage yes --dbfilename dump-5000.rdb --daemonize yes

redis-server --port 5001 --cluster-enabled yes --cluster-config-file nodes-5001.conf --cluster-node-timeout 2000
--cluster-slave-validity-factor 10 --cluster-migration-barrier 1 --cluster-require-full-coverage yes --dbfilename dump-5001.rdb --daemonize yes

redis-server --port 5002 --cluster-enabled yes --cluster-config-file nodes-5002.conf --cluster-node-timeout 2000
--cluster-slave-validity-factor 10 --cluster-migration-barrier 1 --cluster-require-full-coverage yes --dbfilename dump-5002.rdb --daemonize yes
```

* Guardo le informazioni del cluster e provo a impostare una chiave.
* Dovrei avere un errore perché non ancora configurato per completo: `CLUSTERDOWN Hash slot not served`
```
redis-cli -c -p 5000> 
CLUSTER INFO
SET foo bar 
```

* Configurazione degli slot:
```
redis-cli -c -p 5000 CLUSTER ADDSLOTS {0..5460}
redis-cli -c -p 5001 CLUSTER ADDSLOTS {5461..10922}
redis-cli -c -p 5002 CLUSTER ADDSLOTS {10922..16383}
```

* Stato del cluster in un particolare momento:
```
redis-cli -c -p 5000 CLUSTER SET-CONFIG-EPOCH 1
redis-cli -c -p 5001 CLUSTER SET-CONFIG-EPOCH 2
redis-cli -c -p 5002 CLUSTER SET-CONFIG-EPOCH 3
```

* Facciamo conoscere i master tra di loro:
```
redis-cli -c -p 5000 CLUSTER MEET 127.0.0.1 5001
redis-cli -c -p 5000 CLUSTER MEET 127.0.0.1 5002
```

* Check:
```
redis-cli -c -p 5000 > 
CLUSTER INFO
SET hello world # OK!
```

* Adesso dobbiamo aggiungere gli slave:
```
redis-server --port 5003 --cluster-enabled yes --cluster-config-file nodes-5003.conf --cluster-node-timeout 2000
--cluster-slave-validity-factor 10 --cluster-migration-barrier 1 --cluster-require-full-coverage yes --dbfilename dump-5003.rdb --daemonize yes
redis-cli -c -p 5003 CLUSTER MEET 127.0.0.1 5000
redis-cli -c -p 5003 CLUSTER NODES
```

* Proviamo a replicare i dati del master che sta sulla port 5000 E CHE HA ID: bff630f39ac40d2b1d005dbcc18f6bd8ab9f9639
```
redis-cli -c -p 5003 cluster replicate bff630f39ac40d2b1d005dbcc18f6bd8ab9f9639 #OK!
redis-cli -c -p 5003 CLUSTER NODES # Si vede che c'è un ...myself,slave... #OK
```