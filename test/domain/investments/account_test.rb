require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/account_repository_role_test'
require 'investment_tracking_domain/domain/investments/account'

class InvestmentsAccountTest < MiniTest::Test
  def test_it_deposits_money
    account = Investments::Account.new(account_params(unassigned_money: 30))

    account.deposit(1300)

    assert_equal account.unassigned_money, 1330
  end

  def test_it_withdraws_money
    account = Investments::Account.new(account_params(unassigned_money: 1000))

    account.withdraw(300)

    assert_equal account.unassigned_money, 700
  end

  def test_it_raises_when_withdrawing_more_than_available
    account = Investments::Account.new(account_params(unassigned_money: 1000))
    
    assert_raises(Investments::NotEnoughMoney) do
      account.withdraw(1500)
    end
  end

  def test_it_invests_money
    account = Investments::Account.new(account_params(unassigned_money: 1500))

    account.invest(1000)

    assert_equal account.assets.size, 1
    assert_equal account.unassigned_money, 500
  end

  def test_it_raises_when_investing_more_than_available
    account = Investments::Account.new(account_params(unassigned_money: 1000))

    assert_raises(Investments::NotEnoughMoney) do
      account.invest(1500)
    end
  end

  def test_it_sells_an_asset
    # Setup
    selling_price = 723
    after_taxes_price = 500

    asset = MiniTest::Mock.new
    asset.expect :change_price, nil, [selling_price]
    asset.expect :sell, after_taxes_price

    account = Investments::Account.new(
      account_params(
        unassigned_money: 1000,
        assets: [asset]
      )
    )

    # Exercise
    account.sell_asset(
      asset: asset,
      pre_taxes_price: selling_price
    )

    # Verify
    assert_equal account.unassigned_money, 1000 + after_taxes_price
    refute_includes account.assets, asset
  end

  def test_it_raises_if_trying_to_sell_an_unexistent_asset
    asset = ''
    account = Investments::Account.new(
      account_params(assets: [])
    )

    assert_raises(Investments::AssetNotFound) do
      account.sell_asset(asset: asset, pre_taxes_price: 1000)
    end
  end

  private

  def account_params(override)
    {
      id: 1
    }.merge(override)
  end
end

