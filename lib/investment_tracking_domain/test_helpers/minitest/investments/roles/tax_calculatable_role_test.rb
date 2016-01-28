module Investments
  module TaxCalculatableRoleTest
    def test_it_responds_to_days_invested
      assert_respond_to tax_calculatable_object, :days_invested
    end

    def test_it_responds_to_price
      assert_respond_to tax_calculatable_object, :price
    end
  end
end
