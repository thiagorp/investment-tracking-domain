require 'test_helper'
require 'domain/investments/roles/tax_calculatable'
require 'domain/investments/tax_calculators/basic'

class AssetDouble
  attr_reader :days_invested

  def initialize(args)
    @days_invested = args[:days_invested]
  end

  def price
    1000
  end
end

class AssetDoubleTest < MiniTest::Test
  include TaxCalculatable

  def tax_calculatable_object
    AssetDouble.new({})
  end
end

class InvestmentsTaxCalculatorsBasicTest < MiniTest::Test
  def test_it_uses_22_5_percent_when_days_invested_is_less_than_180
    asset = AssetDouble.new(days_invested: 100)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 225, tax
  end

  def test_it_uses_22_5_percent_when_days_invested_is_180
    asset = AssetDouble.new(days_invested: 180)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 225, tax
  end

  def test_it_uses_20_percente_when_days_invested_is_181
    asset = AssetDouble.new(days_invested: 181)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 200, tax
  end

  def test_it_uses_20_percente_when_days_invested_is_between_181_and_360
    asset = AssetDouble.new(days_invested: 272)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 200, tax
  end

  def test_it_uses_20_percente_when_days_invested_is_360
    asset = AssetDouble.new(days_invested: 360)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 200, tax
  end

  def test_it_uses_17_5_percente_when_days_invested_is_361
    asset = AssetDouble.new(days_invested: 361)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 175, tax
  end

  def test_it_uses_17_5_percente_when_days_invested_is_between_361_and_720
    asset = AssetDouble.new(days_invested: 542)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 175, tax
  end

  def test_it_uses_176_percente_when_days_invested_is_720
    asset = AssetDouble.new(days_invested: 720)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 175, tax
  end

  def test_it_uses_15_percente_when_days_invested_is_721
    asset = AssetDouble.new(days_invested: 721)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 150, tax
  end

  def test_it_uses_15_percente_when_days_invested_is_over_721
    asset = AssetDouble.new(days_invested: 800)
    calculator = Investments::TaxCalculators::Basic.new(asset: asset)

    tax = calculator.calculate_tax

    assert_equal 150, tax
  end
end
