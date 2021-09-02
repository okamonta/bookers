class BooksController < ApplicationController
  
  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all.order(created_at: :desc)
    # indexで新規投稿があるためnewアクションがいらない。indexアクションにインスタンス変数を定義する。（メンターさん）
    @book = Book.new
  end
  
  def create
    # (@をつけたらcreateできたが内容が反映されない @book_params @book.save @book.id)
    @book = Book.new(book_params)
    if @book.save
      # messageでない
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      # flash[:alert] = "An error occurred."
      # エラーメッセージを表示するにはelse時にインスタンス変数を定義する（メンターさん）。基本、アクションで定義する。
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path
    else
      flash[:alert] = "An error occurred."
      @book = Book.find(params[:id])
      render :edit
      # render ("books/edit")
      # redirect_to edit_book_path(book.id)
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