class BooksController < ApplicationController
	before_action :correct_user, only: [:edit, :update]
	before_action :authenticate_user!

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@books = Book.all
    	@book.user_id = current_user.id
    	if @book.save
    		flash[:notice] = "successfully"
    		redirect_to book_path(@book)
    	else
    		@user = current_user
    		#flash[:notice] = "error"
    		render "index"
    	end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@user = current_user
		@postbook = Book.new
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "successfully"
			redirect_to book_path(@book)
		else
			flash[:notice] = "error"
			render "edit"
		end
	end
	def edit
		@book = Book.find(params[:id])
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private

	def correct_user
		@book = Book.find(params[:id])
		if @book.user != current_user
			redirect_to books_path
		end
	end

	def book_params
		params.require(:book).permit(:title, :body)
	end
end
