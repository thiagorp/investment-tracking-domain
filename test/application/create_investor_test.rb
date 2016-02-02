require 'test_helper'
require 'investment_tracking_domain/application/create_investor'
require 'domain/investments/fakes/investor_repository_fake' 

class CreateInvestorTest < MiniTest::Test
  def test_it_creates_an_investor
    listener.expect :investor_created, nil, [Object]
    operation = Application::CreateInvestor.new(operation_params)

    operation.create_investor(valid_investor_params)

    assert_equal 1, investor_repository.investors.size
    listener.verify
  end

  private

  def valid_investor_params
    {
      name: 'Investor Name'
    }
  end

  def investor_repository
    @investor_repository ||= InvestorRepositoryFake.new
  end

  def listener
    @listener ||= MiniTest::Mock.new
  end

  def operation_params(override = {})
    {
      investor_repository: investor_repository,
      listener: listener
    }.merge(override)
  end
end
