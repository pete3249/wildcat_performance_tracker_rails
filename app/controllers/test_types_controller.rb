class TestTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_test_type, only: [:show, :edit, :update]

    rescue_from ActiveRecord::RecordNotFound, with: :handle_test_type_not_found

    def index
        @test_types = TestType.all
    end

    def show
        filter_tests
    end

    def new
        @test_type = TestType.new
    end

    def create
        @test_type = TestType.new(test_type_params)

        if @test_type.save
            redirect_to test_type_path(@test_type)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @test_type.update(test_type_params)
            redirect_to test_type_path(@test_type)
        else
            render :edit
        end
    end

    def handle_test_type_not_found
        flash[:error] = "Test type not found"
        redirect_to test_types_path
    end

    private

    def test_type_params
        params.require(:test_type).permit(:name)
    end 

    def set_test_type
        @test_type = TestType.find(params[:id])
    end

    def filter_tests
        if params[:rank] == "top_scores"
            if params[:id] == "1" || params[:id] == "2"
                @performance_tests = @test_type.performance_tests.top_scores
            elsif params[:id] == "3" || params[:id] == "4"
                @performance_tests = @test_type.performance_tests.top_sprinting_scores
            end 
        else
            @performance_tests = @test_type.performance_tests
        end 
    end 

end
