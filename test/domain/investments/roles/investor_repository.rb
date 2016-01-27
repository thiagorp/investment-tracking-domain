module Investments
  module InvestorRepository
    def test_it_responds_to_create_investor
      assert_respond_to repository, :create_investor
    end
  end
end
