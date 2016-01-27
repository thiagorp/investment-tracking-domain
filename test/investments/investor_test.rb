require 'test_helper'
require 'investments/investor'

class InvestmentsInvestorTest < MiniTest::Test
  def test_it_opens_an_account
    investor = Investments::Investor.new({})
    account = 'New account'

    investor.open_account(account)

    assert_includes investor.accounts, account
  end
end
