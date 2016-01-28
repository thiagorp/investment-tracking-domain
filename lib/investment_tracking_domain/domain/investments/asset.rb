require 'investment_tracking_domain/domain/investments/tax_calculators/basic'

module Investments
  class Asset
    attr_reader :id, :price, :start_date

    def initialize(args)
      @id = args[:id]
      @initial_amount = args[:initial_amount]
      @price = args[:amount] || @initial_amount
      @start_date = args[:start_date]

      @tax_calculator = args.fetch(
        :tax_calculator,
        TaxCalculators::Basic.new(asset: self)
      )
    end

    def change_price(new_price)
      @price = new_price
    end

    def sell
      price - tax_calculator.calculate_tax
    end

    def days_invested
      Date.today - start_date
    end

    private

    def tax_calculator
      @tax_calculator
    end
  end
end
