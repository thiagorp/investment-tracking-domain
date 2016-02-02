require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/investor_repository_role_test'

class InvestorRepositoryFake
  attr_reader :investors, :updated_investors

  def initialize(args = {})
    @investors = args.fetch(:investors, [])
    @updated_accounts = ''
  end

  def create_investor(investor)
    @investors << investor
  end

  def update_investor(investor)
    @updated_investors << investor
  end
end

class InvestorRepositoryFakeTest < MiniTest::Test
  include Investments::InvestorRepositoryRoleTest

  def repository
    InvestorRepositoryFake.new
  end
end
