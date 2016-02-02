require 'test_helper'
require 'investment_tracking_domain/domain/investments/investor'

class InvestmentsInvestorTest < MiniTest::Test
  private

  def investor_params(override = {})
    {
      id: 1,
      name: 'Test Investor',
    }.merge(override)
  end
end
