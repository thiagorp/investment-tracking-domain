module Application
  class CreateInvestor
    def initialize(args)
      @investor_class = args.fetch(:investor_class, Investments::Investor)
      @investor_repository = args[:investor_repository]
      @listener = args[:listener]
    end

    def create_investor(investor_params)
      investor = @investor_class.new(
        investor_params.merge(repository: @investor_repository)
      )
      @listener.investor_created(investor)
    end
  end
end
