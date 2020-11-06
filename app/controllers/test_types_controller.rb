class TestTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_test_type, only: [:show, :edit, :update, :destroy]

    def index
        @test_types = TestType.all
    end

    def show
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

    private

    def test_type_params
        params.require(:test_type).permit(:name)
    end 

    def set_test_type
        @test_type = TestType.find(params[:id])
    end

end
