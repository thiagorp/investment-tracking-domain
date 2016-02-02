module Investments
  module AccountRepositoryRoleTest
    def test_it_responds_to_create_account
      assert_respond_to repository, :create_account
      assert_equal repository.method(:create_account).arity, 1
    end

    def test_it_responds_to_update_account
      assert_respond_to repository, :update_account
      assert_equal repository.method(:update_account).arity, 1
    end
  end
end
