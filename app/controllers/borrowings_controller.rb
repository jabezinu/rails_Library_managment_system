class BorrowingsController < ApplicationController
  before_action :set_borrowing, only: [:show, :return_book]

  def index
    @active_borrowings = Borrowing.active.includes(:student, :book)
    @returned_borrowings = Borrowing.returned.includes(:student, :book).limit(20)
  end

  def show
  end

  def new
    @borrowing = Borrowing.new
    @students = Student.all
    @available_books = Book.available.includes(:category)
  end

  def create
    @borrowing = Borrowing.new(borrowing_params)
    @students = Student.all
    @available_books = Book.available.includes(:category)
    
    if @borrowing.save
      redirect_to @borrowing, notice: 'Book was successfully borrowed.'
    else
      render :new
    end
  end

  def return_book
    if @borrowing.return_book!
      redirect_to borrowings_path, notice: 'Book was successfully returned.'
    else
      redirect_to @borrowing, alert: 'Failed to return book.'
    end
  end

  def active
    @borrowings = Borrowing.active.includes(:student, :book)
  end

  def history
    @borrowings = Borrowing.returned.includes(:student, :book).order(returned_at: :desc)
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end

  def borrowing_params
    params.require(:borrowing).permit(:student_id, :book_id)
  end
end