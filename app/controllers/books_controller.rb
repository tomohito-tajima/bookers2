class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end
  
  def show
    @user = current_user
    @books = Book.all
  end

  def edit
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    # @book = Book.find(params[:id]) ActiveRecord::RecordNotFound in BooksController#destroy
    #@book.destroy
    #redirect_to books_path
  end

   private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :name)
  end

end