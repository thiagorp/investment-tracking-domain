module Investments
  module AccountRepository
    def test_it_responds_to_create_account
      assert_respond_to repository, :create_account
    end

    def test_it_responds_to_update_amount
      assert_respond_to repository, :update_amount
    end

    def test_it_responds_to_create_asset
      assert_respond_to repository, :create_asset
    end

    def test_it_responds_to_destroy_asset
      assert_respond_to repository, :destroy_asset
    end
  end
end
