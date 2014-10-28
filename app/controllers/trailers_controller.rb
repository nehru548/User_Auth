class TrailersController < ApplicationController
	def index
      @trailers = Trailer.search params[:search]
    end
end
