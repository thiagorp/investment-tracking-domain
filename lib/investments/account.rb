module Investments
  class Account
    attr_reader :unassigned_money, :investments

    def initialize(args)
      @unassigned_money = args[:unassigned_money]
      @investments = args[:investments] || []
    end

    def deposit(amount)
      @unassigned_money += amount
    end

    def invest(amount, asset_class: Asset)
      raise NotEnoughMoney unless have_enough_money?(amount)

      @unassigned_money -= amount
      @investments << asset_class.new(
        initial_amount: amount,
        start_date: Date.today
      )
    end

    private

    def have_enough_money?(amount)
      unassigned_money >= amount
    end

    def build_new_asset(asset_class)
    end
  end

  class NotEnoughMoney < StandardError; end
end
