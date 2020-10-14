class UsersController < ApplicationController
  before_action :authenticate_user!,:new_book
    before_action :check_current_user_plofile, only: [:edit, :update ]
    
    def index
        @users = User.all
        @user_new = User.new
        @new_book = Book.new
        @user = User.find(current_user.id)
    end

    def show
        @user = User.find(params[:id])
        @books = @user.books
        @new_book = Book.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
      if @user.update(user_params)
          flash[:notice] = "successfully update."
        redirect_to user_path(@user.id)

      else
        render :edit
      end
    end

  def create
    @book = Book.new(book_params)
  if@book.save
    flash[:notice] = 'successfully'
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    render "index"
  end
  end

    private
  def new_book
    @newbook = Book.new
  end
  
  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

  def check_current_user_plofile
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end
end