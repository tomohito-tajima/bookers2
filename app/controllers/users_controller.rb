class UsersController < ApplicationController

  def show
    @user = current_user
    @book = Book.new
    @books = Book.find(params[:id])
  end

  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end

  def edit
  end

  def update
  end
end
