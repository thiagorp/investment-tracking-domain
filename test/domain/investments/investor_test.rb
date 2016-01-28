require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/investor_repository_role_test'
require 'investment_tracking_domain/domain/investments/investor'

class InvestorRepositoryDouble
  def create_investor(investor)
  end
end

class InvestorRepositoryDoubleTest < MiniTest::Test
  include Investments::InvestorRepositoryRoleTest

  def repository
    InvestorRepositoryDouble.new
  end
end

class InvestmentsInvestorTest < MiniTest::Test
  def test_it_calls_create_investor_on_repository_if_id_is_nil
    repository = MiniTest::Mock.new
    repository.expect :create_investor, true, [Investments::Investor]

    Investments::Investor.new(
      investor_params(id: nil, repository: repository)
    )

    repository.verify
  end

  def test_it_opens_an_account
    investor = Investments::Investor.new(investor_params)
    account = 'New account'

    investor.open_account(account)

    assert_includes investor.accounts, account
  end

  private

  def investor_params(override = {})
    {
      id: 1,
      name: 'Test Investor',
      repository: InvestorRepositoryDouble.new
    }.merge(override)
  end
end
