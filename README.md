# Money

Currency conversion and arithmetics with different currencies.

## Getting Starting

### Installation
Is not in Rubygems yet, so from your Gemfile:
```ruby
  gem 'money', :git => 'git://github.com/lmanotas/money.git' 
```
### Configure Rates
```ruby
Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047
})
```

### Usage
```ruby
# Instantiate money objects:

fifty_eur = Money.new(50, 'EUR')

# Get amount and currency:

fifty_eur.amount   # => 50
fifty_eur.currency # => "EUR"
fifty_eur.inspect  # => "50.00 EUR"
```
### Conversion Methods
```ruby

fifty_eur.convert_to('USD') # => 55.50 USD

twenty_dollars = Money.new(20, 'USD')
````
### Arithmetic Methods
```ruby

fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD
```
### Comparing Currencies
```ruby

twenty_dollars == Money.new(20, 'USD') # => true
twenty_dollars == Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true

twenty_dollars > Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true
```

# Contributing to Money

Just fork it, create your feature branch and send a pull request.

````
$ git clone git@github.com:lmanotas/money.git
$ cd money
$ bundle install
````

Add your fork remote and you are Ready to Rock!.

## Requirements
* Ruby 2.x.x
* bundler


## Running Tests
```
$ rake
```
or using bundler
````
$ bundle exec rspec
````