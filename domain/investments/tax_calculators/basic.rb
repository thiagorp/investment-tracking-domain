module Investments
  module TaxCalculators
    class Basic
      attr_reader :asset

      def initialize(args)
        @asset = args[:asset]
      end

      def calculate_tax
        asset.price * tax_for(asset.days_invested) / 100.0
      end

      private

      def tax_for(days_invested)
        if days_invested <= 180
          22.5
        elsif days_invested > 180 && days_invested <= 360
          20.0
        elsif days_invested > 360 && days_invested <= 720
          17.5
        elsif days_invested > 720
          15.0
        end
      end
    end
  end
end
