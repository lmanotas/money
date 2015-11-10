class Money
  module Operations
    
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
end