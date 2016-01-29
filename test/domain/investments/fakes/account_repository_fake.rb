require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/account_repository_role_test'

class AccountRepositoryFake
  attr_reader :accounts, :assets, :amount_updated

  def initialize(args = {})
    @accounts = args.fetch(:accounts, [])
    @assets = args.fetch(:assets, [])
    @amounts_updated = []
  end

  def create_account(account)
    @accounts << account
  end

  def update_amount(account)
    @amounts_updated << account.dup
  end

  def create_asset(account, asset)
    @assets << asset
  end

  def destroy_asset(asset)
    @assets.delete(asset)
  end

  # Extra helper methods
  def updated_amount_for(account, new_amount)
    @amounts_updated.any? do |updated|
      updated.id == account.id && updated.unassigned_money == new_amount
    end
  end
end

class AccountRepositoryFakeTest < MiniTest::Test
  include Investments::AccountRepositoryRoleTest

  def repository
    AccountRepositoryFake.new
  end
end
