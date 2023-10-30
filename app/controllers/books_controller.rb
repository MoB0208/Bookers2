class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @new_book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @new_book = Book.new


  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)

      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

 private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
