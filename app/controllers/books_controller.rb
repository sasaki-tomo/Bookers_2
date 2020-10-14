class BooksController < ApplicationController
  before_action :authenticate_user!, :new_book
  before_action :check_current_user_book, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @user = current_user
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @new_book = Book.new
  end

  def new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
       flash[:notice] = "successfully"
       redirect_to book_path(@new_book.id)
    else
       @books = Book.all
       @user = current_user
       flash[:notice] = "error"
       render:index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(@book)
    else
       render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def new_book
    @newbook = Book.new
  end


  def book_params
    params.require(:book).permit(:title, :body)
  end

  def check_current_user_book
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end
end
