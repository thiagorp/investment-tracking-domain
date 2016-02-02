module Investments
  class Investor
    attr_reader :id, :name

    def initialize(args)
      @name = args[:name]
      @id = args[:id]
    end
  end
end
