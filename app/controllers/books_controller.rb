class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :borrow]

  def index
    @books = Book.includes(:category).all
    @available_books = Book.available.count
    @out_of_stock_books = Book.out_of_stock.count
  end

  def show
    @current_borrower = @book.current_borrower
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new(book_params)
    @categories = Category.all
    
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    @categories = Category.all
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully deleted.'
  end

  def borrow
    student = Student.find(params[:student_id])
    borrowing = @book.borrowings.build(student: student)
    
    if borrowing.save
      redirect_to @book, notice: "Book successfully borrowed by #{student.name}."
    else
      redirect_to @book, alert: borrowing.errors.full_messages.join(', ')
    end
  end

  def out_of_stock
    @books = Book.out_of_stock.includes(:category, :borrowings)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :category_id, :available)
  end
end