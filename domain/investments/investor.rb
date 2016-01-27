module Investments
  class Investor
    attr_reader :id, :name, :accounts

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @accounts = args[:accounts] || []
    end

    def open_account(account)
      @accounts << account
    end
  end
end
