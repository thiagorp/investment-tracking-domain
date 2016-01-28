module Investments
  module InvestorRepositoryRoleTest
    def test_it_responds_to_create_investor
      assert_respond_to repository, :create_investor
      assert_equal repository.method(:create_investor).arity, 1
    end
  end
end
