describe Money do

  before do
    Money.conversion_rates('EUR', {
      'USD'     => 1.11,
      'Bitcoin' => 0.0047
    })
  end

  describe "attributes" do
    let(:amount){ 50 }
    let(:currency){ 'EUR' }
    subject(:money){ Money.new(amount, currency) }

    context "initialize" do
      it "amount should be stored as float" do
        expect(money.amount).to eq(50)
      end

      it "currency should be stored " do
        expect(money.currency).to eq('EUR')
      end
    end

    context "inspect" do
      it "should return ie. 50 EUR" do
        expect(money.inspect).to eq("50.00 EUR")
      end
    end
  end

  describe "Arithmetics" do
    let(:ten_euros){ Money.new(10, 'EUR') }
    let(:forty_euros){ Money.new(40, 'EUR') }

    context "+ same currencies" do
      it "add same currency objects" do
        simple_add = ten_euros + forty_euros
        expect(simple_add.inspect).to eq("50.00 EUR")
      end
    end

    context "+|- different currencies" do
      let(:fifty_euros){ Money.new(50, 'EUR') }
      let(:twenty_dollars){ Money.new(20, 'USD') }
      let(:different_currency_add){ fifty_euros + twenty_dollars }
      let(:different_currency_subtract){ fifty_euros - twenty_dollars }

      it "add EUR and USD" do
        expect(different_currency_add.inspect).to eq("68.02 EUR")
      end

      it "subtract EUR and USD" do
        expect(different_currency_subtract.inspect).to eq("31.98 EUR")
      end
    end

    context "- same currencies" do
      it "subtract same currency objects" do
        subtract = forty_euros - ten_euros
        expect(subtract.inspect).to eq("30.00 EUR")
      end
    end

    context "* multiply" do
      it "multiply money currency" do
        multiply = forty_euros * 20
        expect(multiply.inspect).to eq("800.00 EUR")
      end
    end

    context "/ divide" do
      it "divide money currency" do
        divide = forty_euros / 2
        expect(divide.inspect).to eq("20.00 EUR")
      end
    end    
  end

  describe "Convert to different currency" do
    let(:base_currency){ 'EUR' }
    let(:default_rates) do
      {
        'USD'     => 1.11,
        'Bitcoin' => 0.0047
      }
    end

    before do
      Money.conversion_rates(base_currency, default_rates)
    end

    context "Conf conversion rates" do
      it "allows to configure the base currency" do
        expect(Money.class_variable_get(:@@base_currency)).to eq(base_currency)
      end

      it "allows to configure conversion rates" do
        expect(Money.class_variable_get(:@@rates)).to eq(default_rates)
      end      
    end

    context "convert_to currency" do
      let(:fifty_euros){ Money.new(50, 'EUR') }
      let(:eur_to_usd){ fifty_euros.convert_to('USD') }

      it "EUR to USD (registred currency)" do
        expect(eur_to_usd.inspect).to eq("55.50 USD")
      end

      it "Returns a Money object" do
        expect(eur_to_usd).to be_kind_of(Money)
      end
    end
  end

  describe "Comparisons" do
    let(:fifty_euros){ Money.new(50, 'EUR') }
    let(:twenty_dollars){ Money.new(20, 'USD') }
    let(:thirdty_dollars){ Money.new(30, 'USD') }
    
    context "== comparisions" do
      let(:twenty_dollars_in_eur){ twenty_dollars.convert_to('EUR') }

      it "true case" do
        expect(twenty_dollars == Money.new(20, 'USD')).to eq(true)
      end

      it "false case" do
        expect(twenty_dollars == Money.new(40, 'USD')).to eq(false)
      end

      it "true case, different currencies" do
        expect(twenty_dollars == twenty_dollars_in_eur).to eq(true)
      end
    end

    context "> comparisions" do
      it "true case" do
        expect(fifty_euros > twenty_dollars).to be(true)
      end

      it "false case" do
        expect(twenty_dollars > fifty_euros).to be(false)
      end

      it "true case, different currencies" do
        expect(Money.new(50, 'EUR') > Money.new(50, 'USD')).to eq(true)
      end
    end

    context "< comparisions" do
      it "true case" do
        expect(twenty_dollars < fifty_euros).to be(true)
      end

      it "false case" do
        expect(fifty_euros < twenty_dollars).to be(false)
      end

      it "true case, different currencies" do
        expect(Money.new(50, 'USD') < Money.new(50, 'EUR')).to eq(true)
      end
    end
  end
end