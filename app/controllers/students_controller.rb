class StudentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_student, only: [:show, :edit, :update, :destroy]
    
    rescue_from ActiveRecord::RecordNotFound, with: :handle_student_not_found

    def index  
        @students = Student.all
        filter_students
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
        params.require(:student).permit(:name, :grad_year)
    end 

    def set_student
        @student = Student.find(params[:id])
    end

    def filter_students
        if params[:filter_by_year] == "2021"
            @students = Student.all.by_grad_year("2021")
        elsif params[:filter_by_year] == "2022"
            @students = Student.all.by_grad_year("2022")
        elsif params[:filter_by_year] == "2023"
            @students = Student.all.by_grad_year("2023")
        elsif params[:filter_by_year] == "2024"
            @students = Student.all.by_grad_year("2024")
        end 
    end 

end
