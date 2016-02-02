require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/account_repository_role_test'

class AccountRepositoryFake
  attr_reader :accounts, :updated_accounts

  def initialize(args = {})
    @accounts = args.fetch(:accounts, [])
    @updated_accounts = []
  end

  def create_account(account)
    @accounts << account
  end

  def update_account(account)
    @updated_accounts << account
  end
end

class AccountRepositoryFakeTest < MiniTest::Test
  include Investments::AccountRepositoryRoleTest

  def repository
    AccountRepositoryFake.new
  end
end
