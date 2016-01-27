require 'test_helper'
require 'domain/investments/roles/account_repository'
require 'investments/account'

class AccountRepositoryDouble
  def create_account(account)
  end

  def update_amount(account)
  end

  def create_asset(account, asset)
  end

  def destroy_asset(asset)
  end
end

class AccountRepositoryDoubleTest < MiniTest::Test
  include Investments::AccountRepository

  def repository
    AccountRepositoryDouble.new
  end
end

class InvestmentsAccountTest < MiniTest::Test
  def test_it_calls_create_account_on_repository_if_no_id_is_given
    repository = MiniTest::Mock.new
    repository.expect :create_account, true, [Investments::Account]

    Investments::Account.new(
      account_params(
        id: nil,
        repository: repository
      )
    )

    repository.verify
  end

  def test_it_deposits_money
    repository = MiniTest::Mock.new
    repository.expect :update_amount, true, [Investments::Account]
    account = Investments::Account.new(
      account_params(
        unassigned_money: 0,
        repository: repository
      )
    )

    account.deposit(1300)

    repository.verify
    assert_equal account.unassigned_money, 1300
  end

  def test_it_withdraws_money
    repository = MiniTest::Mock.new
    repository.expect :update_amount, true, [Investments::Account]
    account = Investments::Account.new(
      account_params(
        unassigned_money: 1000,
        repository: repository
      )
    )

    account.withdraw(300)

    repository.verify
    assert_equal account.unassigned_money, 700
  end

  def test_it_raises_when_withdrawing_more_than_available
    account = Investments::Account.new(
      account_params(unassigned_money: 1000)
    )
    
    assert_raises(Investments::NotEnoughMoney) do
      account.withdraw(1500)
    end
  end

  def test_it_invests_money
    # Setup
    repository = Minitest::Mock.new
    repository.expect :update_amount, true, [Investments::Account]
    repository.expect :create_asset, true, [Investments::Account, Object]

    asset_class = MiniTest::Mock.new
    asset_class.expect(
      :new,
      'new investment',
      [
        {
          initial_amount: 1000,
          start_date: Date.today,
          repository: repository
        }
      ]
    )

    account = Investments::Account.new(
      account_params(
        unassigned_money: 1500,
        repository: repository
      )
    )

    # Exercise
    account.invest(1000, asset_class: asset_class)

    # Verify
    asset_class.verify
    repository.verify
    assert_equal account.unassigned_money, 500
    assert_includes account.assets, 'new investment'
  end

  def test_it_raises_when_investing_more_than_available
    account = Investments::Account.new(
      account_params(unassigned_money: 1000)
    )

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

    repository = MiniTest::Mock.new
    repository.expect :update_amount, true, [Investments::Account]
    repository.expect :destroy_asset, true, [Object]

    account = Investments::Account.new(
      account_params(
        unassigned_money: 1000,
        repository: repository,
        assets: [asset]
      )
    )

    # Exercise
    account.sell_asset(
      asset: asset,
      pre_taxes_price: selling_price
    )

    # Verify
    asset.verify
    repository.verify
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
      id: 1,
      repository: AccountRepositoryDouble.new
    }.merge(override)
  end
end

