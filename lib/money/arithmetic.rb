class Money
  module Arithmetic
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
  end
end