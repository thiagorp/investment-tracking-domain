module Investments
  class Investor
    attr_reader :id, :name, :accounts

    def initialize(args)
      @name = args[:name]
      @accounts = args[:accounts] || []
      @repository = args[:repository]

      @id = @repository.create_investor(self)
    end

    def open_account(account)
      @accounts << account
    end
  end
end
