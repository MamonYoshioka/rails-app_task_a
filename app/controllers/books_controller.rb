class BooksController < ApplicationController
  before_action :current_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
  end

  def index
    # @books = Book.all
    @book = Book.new
    to_day = Time.current.at_end_of_day
    from = (to_day - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
    sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to_day).size
      }.reverse
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def current_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
