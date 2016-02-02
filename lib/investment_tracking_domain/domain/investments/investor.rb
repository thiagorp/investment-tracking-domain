module Investments
  class Investor
    attr_reader :id, :name

    def initialize(args)
      @name = args[:name]

      @id = @repository.create_investor(self)
    end
  end
end
