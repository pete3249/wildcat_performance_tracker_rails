class StudentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_student, only: [:show, :edit, :update, :destroy]
    
    rescue_from ActiveRecord::RecordNotFound, with: :handle_student_not_found

    def index 
        @students = Student.all 
        @students = @students.filter_students(filter_student_params) if filter_student_params.present?
        @students = @students.search_by_name(params[:search_by_name]) if params[:search_by_name].present?
    end

    def show
    end

    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)

        if @student.save
            redirect_to student_path(@student)
        else
            render :new
        end 
    end

    def edit
    end

    def update
        if @student.update(student_params)
            redirect_to student_path(@student)
        else
            render :edit
        end
    end

    def destroy
        @student.destroy
        redirect_to students_path
    end

    def handle_student_not_found
        flash[:error] = "Student not found"
        redirect_to students_path
    end

    private

    def student_params
        params.require(:student).permit(
            :name, 
            :grad_year, 
            performance_tests_attributes:[
                :test_type_id,
                :result,
                :date_taken,
                :notes,
                :user_id
            ]
        )
    end 

    def filter_student_params
        params.permit(:filter_by_year)
    end 

    def set_student
        @student = Student.find(params[:id])
    end

end
