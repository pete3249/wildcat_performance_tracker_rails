class PerformanceTestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_performance_test, only: [:edit, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound, with: :handle_performance_test_not_found

    def index
        @student = Student.find_by(id: params[:student_id])
        if @student
            @performance_tests = @student.performance_tests
        else
            @performance_tests = PerformanceTest.all
        end
        filter_options 
    end

    def show
        @student = Student.find_by(id: params[:student_id])
        @performance_test = @student.performance_tests.find_by(id: params[:id])
    end

    def new
        @student = Student.find_by(id: params[:student_id])
        if @student
            @performance_test = @student.performance_tests.build(student_id: params[:student_id])
        else
            @performance_test = PerformanceTest.new
        end 
        
    end 

    def create
        @performance_test = current_user.performance_tests.build(performance_test_params)
        if @performance_test.save
            redirect_to performance_test_path(@performance_test)
        else
            render :new
        end 
    end

    def edit
    end

    def update
        if @performance_test.update(performance_test_params)
            redirect_to performance_test_path(@performance_test)
        else
            render :edit
        end 
    end

    def destroy
        @performance_test.destroy
        redirect_to performance_tests_path
    end

    def handle_performance_test_not_found
        flash[:error] = "You are not authorized to edit performance tests you did not create."
        redirect_to performance_tests_path
    end

    private

    def performance_test_params
        params.require(:performance_test).permit(:notes, :result, :date_taken, :user_id, :student_id, :test_type_id)
    end 

    def set_performance_test
        @performance_test = current_user.performance_tests.find(params[:id])
    end

    def filter_options
        if params[:filter_by_type] == "vertical"
            @performance_tests = @performance_tests.by_test_type(1)
        elsif params[:filter_by_type] == "broad" 
            @performance_tests = @performance_tests.by_test_type(2)
        elsif params[:filter_by_type] == "40" 
            @performance_tests = @performance_tests.by_test_type(3)
        elsif params[:filter_by_type] == "shuttle"
            @performance_tests = @performance_tests.by_test_type(4)
        end

        if params[:sort] == "most_recent"
            @performance_tests = @performance_tests.most_recent
        elsif params[:sort] == "old"
            @performance_tests = @performance_tests.old
        end 

    end

end
