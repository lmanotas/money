require 'money/convertible'
require 'money/operations'
require 'money/arithmetic'

class Money
  include Money::Convertible
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