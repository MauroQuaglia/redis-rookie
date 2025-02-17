require_relative('../redis_client_base.rb')

class UnwatchTransaction < RedisClientBase
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
    # OK, ho fondo sufficiente.
    funds = @client.get(@from).to_i

    sleep(30)
    # Se adesso cambio il valore di @from, magari svuotando il conto, la transazione successiva viene comunque eseguita, il che è male!

    # Adesso in realtà potrei non averne a sufficienza!
    if funds >= value
      @client.multi do |multi|
        multi.decrby(@from, value)
        multi.incrby(@to, value)
      end
    end
  end
end

ut = UnwatchTransaction.new('MQ', 'SS')
ut.setup
ut.transfer(20)
ut.close_connection