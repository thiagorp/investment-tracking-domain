module Application
  class CreateInvestor
    def initialize(args)
      @investor_repository = args[:investor_repository]
      @listener = args[:listener]
    end

    def create_investor(investor_params)
      investor = Investments::Investor.new(investor_params)
      @investor_repository.create_investor(investor)
      @listener.investor_created(investor)
    end
  end
end
