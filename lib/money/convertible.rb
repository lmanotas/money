class Money
  @@base_currency = ''
  @@rates = {}

  class << self
    def conversion_rates(base_currency, rates = {})
      @@base_currency = base_currency
      @@rates = rates
    end
  end

  module Convertible
    def convert_to(to_currency)
      if to_currency == self.class.class_variable_get(:@@base_currency)
        to_base_currency
      else
        rate = self.class.class_variable_get(:@@rates)[to_currency]
        converted_amount = (amount * rate).round(2)
        Money.new(converted_amount, to_currency)
      end
    end

    def to_base_currency
      if currency == self.class.class_variable_get(:@@base_currency)
        self
      else
        rate = self.class.class_variable_get(:@@rates)[currency]
        Money.new( (amount / rate).round(2), self.class.class_variable_get(:@@base_currency) )  
      end
    end
  end
end