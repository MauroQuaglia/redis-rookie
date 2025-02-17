require_relative('../redis_client_base.rb')

class WatchTransaction < RedisClientBase
  def initialize(from, to)
    @from = from
    @to = to
    super()
  end

  def setup
    @client.set("MQ", 100)
    @client.set("SS", 100)
  end

  def transfer(value)
    @client.watch(@from)
    # OK, ho fondo sufficiente.
    funds = @client.get(@from).to_i

    sleep(30)
    # Se adesso cambio il valore di @from, magari svuotando il conto, la transazione successiva non viene eseguita, il che è bene!

    # Adesso in realtà potrei non averne a sufficienza
    if funds >= value
      @client.multi do |multi|
        multi.decrby(@from, value)
        multi.incrby(@to, value)
      end
    end

    @client.unwatch
  end

  def transfer2(value)
    # Se un altro client cambia nel frattempo il valore del from, il tutto viene ivalidato.
    @client.watch(@from)

    # Così da CLI posso provare a cambiare il valore.
    # Se cambio valore la transazione viene invalidata, infatti da Redis si vede che i valori non sono cambiati.
    sleep(30)

    funds = @client.get(@from).to_i
    if funds >= value
      @client.multi do |multi|
        multi.decrby(@from, value)
        multi.incrby(@to, value)
      end
    end

    @client.unwatch
  end
end

wt = WatchTransaction.new('MQ', 'SS')
wt.setup
wt.transfer(20)
wt.close_connection