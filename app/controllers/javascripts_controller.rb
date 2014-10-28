class JavascriptsController < ApplicationController
	def dynamic_centers
  		@centers = Center.all
	end
end
