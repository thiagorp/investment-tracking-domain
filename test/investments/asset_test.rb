require 'test_helper'
require 'investments/asset'

class InvestmentsAssetTest < MiniTest::Test
  def test_it_updates_its_price_if_valid
    asset = Investments::Asset.new(initial_amount: 1000)

    asset.change_price(1100)

    assert_equal asset.price, 1100
  end

  def test_it_sells_itself_and_calculate_the_tax_if_taxable
    # Setup
    tax_calculator = MiniTest::Mock.new
    selling_amount = 100
    tax = 15

    asset = Investments::Asset.new(
                                amount: selling_amount,
                                taxable: true,
                                tax_calculator: tax_calculator)

    tax_calculator.expect :calculate_tax, tax

    # Exercise
    price = asset.sell

    # Verify
    tax_calculator.verify
    assert_equal price, selling_amount - tax
  end

  def test_it_calculates_the_days_it_remained_invested
    asset = Investments::Asset.new(start_date: days_ago(42))

    days_invested = asset.days_invested

    assert_equal 42, days_invested
  end

  private

  def days_ago(days_ago)
    Date.today - days_ago
  end

  def days_from_now(days)
    days * 24 * 60 * 60
  end
end
