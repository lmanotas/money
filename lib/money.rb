require './lib/money/operations'
require './lib/money/arithmetic'

class Money

  @@base_currency = ''
  @@rates = {}

  class << self
    def conversion_rates(base_currency, rates = {})
      @@base_currency = base_currency
      @@rates = rates
    end
  end
  
  include Money::Operations
  include Money::Arithmetic

  attr_reader :currency

  def initialize(amount, currency)
    @amount   = Float(amount)
    @currency = currency
  end

  def amount
    @amount
  end

  def inspect
    "#{monetary_format} #{currency}"
  end

  private
  def monetary_format
    sprintf("%.2f", amount) 
  end
end