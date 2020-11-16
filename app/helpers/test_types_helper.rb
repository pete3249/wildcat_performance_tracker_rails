module TestTypesHelper

    def add_units(performance_test)
        if performance_test.test_type_id == "1" || performance_test.test_type_id == "2"
            labeled_test = add_inches(performance_test.result)
        else
            labeled_test = add_secs(performance_test.result)
        end
        labeled_test
    end 

    def add_inches(result)
        "#{result} in"
    end 

    def add_secs(result)
        "#{result} sec"
    end 

end
