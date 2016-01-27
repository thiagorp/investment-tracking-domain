module Investments
  class Investor
    attr_reader :name, :accounts

    def initialize(args)
      @name = args[:name]
      @accounts = args[:accounts] || []
    end

    def open_account(account)
      @accounts << account
    end
  end
end
