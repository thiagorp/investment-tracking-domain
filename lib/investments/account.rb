require 'investments/asset'

module Investments
  class Account
    attr_reader :id, :name, :unassigned_money, :assets

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @unassigned_money = args[:unassigned_money]
      @assets = args[:assets] || []
    end

    def deposit(amount)
      @unassigned_money += amount
    end

    def withdraw(amount)
      raise NotEnoughMoney unless have_enough_money?(amount)
      @unassigned_money -= amount
    end

    def invest(amount, asset_class: Asset)
      withdraw(amount)

      @assets << asset_class.new(
        initial_amount: amount,
        start_date: Date.today
      )
    end

    def sell_asset(asset:, pre_taxes_price:)
      raise AssetNotFound unless assets.include?(asset)

      asset.change_price(pre_taxes_price)
      deposit(asset.sell)
      @assets.delete(asset)
    end

    private

    def have_enough_money?(amount)
      unassigned_money >= amount
    end

    def build_new_asset(asset_class)
    end
  end

  class NotEnoughMoney < StandardError; end
  class AssetNotFound < StandardError; end
end
