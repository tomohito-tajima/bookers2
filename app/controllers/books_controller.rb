class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = @book.user
    if @book.save
      redirect_to book_path(@book.id)
      flash[:success] = "You have created book successfully."
    else
      @books = Book.all
      flash.now[:danger] = "新規投稿に失敗しました"
      render :index
    end
  end

  def index
    # @book = Book.find(params[:id])
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @info = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:success] = "You have updated book successfully."
    else
      flash.now[:danger] = "errors prohibited this obj from being saved:"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to  books_path
    else
      @book.destroy
      redirect_to books_path
    end

  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end