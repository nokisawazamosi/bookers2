class BooksController < ApplicationController

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice]= "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      @user = current_user
      @users = User.all
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @comment = BookComment.new
  end

  def edit
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
    @book = Book.find(params[:id])

  end

  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]= "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
