module Services
  module Integration
    class Numbers

      def fact_for_today
        fact = obtain_fact
        while Tweet.same_as_this_day_last_year?(fact)
          fact = obtain_fact
        end
        fact
      end

      private

      def obtain_fact
        month = Date.today.month
        day = Date.today.day
        res = Typhoeus.get("http://numbersapi.com/#{month}/#{day}/date")
        res.body
      end

    end
  end
end
