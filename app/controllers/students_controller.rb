class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
  end

  def show
    @active_borrowings = @student.active_borrowings.includes(:book)
    @borrowing_history = @student.borrowing_history.includes(:book)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    
    if @student.save
      redirect_to @student, notice: 'Student was successfully registered.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully deleted.'
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :student_id)
  end
end