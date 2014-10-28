class NewsController < ApplicationController
	def show
		@current_user = News.find(params[:id])
	end
	def new
      @news = News.search params[:search]
    end
end
