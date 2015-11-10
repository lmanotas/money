class Money

  @@base_currency = ''
  @@rates = {}

  attr_reader :currency

  class << self
    def conversion_rates(base_currency, rates = {})
      @@base_currency = base_currency
      @@rates = rates
    end
  end

  def initialize(amount, currency)
    @amount   = Float(amount)
    @currency = currency
  end

  def amount
    @amount
  end

  def monetary_format
    sprintf("%.2f", amount) 
  end

  def inspect
    "#{monetary_format} #{currency}"
  end

  def convert_to(to_currency)
    if to_currency == @@base_currency
      to_base_currency
    else
      rate = @@rates[to_currency]
      converted_amount = (amount * rate).round(2)
      Money.new(converted_amount, to_currency)
    end
  end

  def to_base_currency
    if currency == @@base_currency
      self
    else
      rate = @@rates[currency]
      Money.new( (amount / rate).round(2), @@base_currency )  
    end
  end

  def +(money)
    add_amount = currency == money.currency ? money.amount : money.convert_to(currency).amount
    Money.new(amount + add_amount, currency)
  end

  def -(money)
    subtract_amount = currency == money.currency ? money.amount : money.convert_to(currency).amount
    Money.new(amount - subtract_amount, currency)
  end

  def *(number)
    Money.new(amount * number, currency)
  end

  def /(number)
    raise "Can't divide by zero" if number == 0
    Money.new(amount / number, currency)
  end

  def ==(compare)
    self.to_base_currency.amount == compare.to_base_currency.amount
  end

  def >(compare)
    self.to_base_currency.amount > compare.to_base_currency.amount
  end

  def <(compare)
    self.to_base_currency.amount < compare.to_base_currency.amount
  end
end