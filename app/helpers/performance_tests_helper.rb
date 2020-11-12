module PerformanceTestsHelper

    def formatted_time(test)
        test.date_taken.strftime('%b %Y')
    end 

end
