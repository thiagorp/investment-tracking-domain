require 'test_helper'
require 'investments/account'

class InvestmentsAccountTest < MiniTest::Test
  def test_it_deposits_money
    account = Investments::Account.new(unassigned_money: 0)

    account.deposit(1300)

    assert_equal account.unassigned_money, 1300
  end

  def test_it_invests_money
    asset_class = MiniTest::Mock.new
    asset_class.expect(
      :new,
      'new investment',
      [
        {
          initial_amount: 1000,
          start_date: Date.today
        }
      ]
    )
    account = Investments::Account.new(
      unassigned_money: 1500
    )

    account.invest(1000, asset_class: asset_class)

    asset_class.verify
    assert_equal account.unassigned_money, 500
    assert_includes account.investments, 'new investment'
  end

  def test_it_raises_when_investing_more_than_available
    account = Investments::Account.new(
      unassigned_money: 1000
    )

    assert_raises(Investments::NotEnoughMoney) do
      account.invest(1500)
    end
  end
end
