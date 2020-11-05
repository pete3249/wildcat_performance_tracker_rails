class StudentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
        @students = Student.all
    end

    def show
    end

    def new
    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def set_student
        @student = Student.find(params[:id])
    end

end
