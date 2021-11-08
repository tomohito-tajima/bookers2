class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
    #redirect_to book_path(book) 非同期通信を行うため削除
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id]).destroy
    #redirect_to book_path(params[:book_id]) 非同期通信を行うため削除
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
