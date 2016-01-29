module Investments
  module AccountRepositoryRoleTest
    def test_it_responds_to_create_account
      assert_respond_to repository, :create_account
      assert_equal repository.method(:create_account).arity, 1
    end

    def test_it_responds_to_update_amount
      assert_respond_to repository, :update_amount
      assert_equal repository.method(:update_amount).arity, 1
    end

    def test_it_responds_to_create_asset
      assert_respond_to repository, :create_asset
      assert_equal repository.method(:create_asset).arity, 2
    end

    def test_it_responds_to_destroy_asset
      assert_respond_to repository, :destroy_asset
      assert_equal repository.method(:destroy_asset).arity, 1
    end
  end
end
