module Services
  module Integration
    class Numbers

      def fact_for_today
        month = Date.today.month
        day = Date.today.day
        res = Typhoeus.get("http://numbersapi.com/#{month}/#{day}/date")
        res.body
      end

    end
  end
end
