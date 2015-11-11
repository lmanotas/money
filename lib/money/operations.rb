class Money
  module Operations
    
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