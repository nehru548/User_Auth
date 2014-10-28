class Feedback < ActiveRecord::Base
	attr_accessible :movie_name,:user_name, :rating, :comment
	
end