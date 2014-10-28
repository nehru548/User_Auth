class Booking < ActiveRecord::Base
	attr_accessible :movie_id, :center_id, :date, :time,:no_tickets
	validates :movie_id, :presence => "true"
	validates :center_id, :presence => "true"
	validates :date, :presence => "true"
	validates :time, :presence => "true"
	validates :no_tickets, :presence => "true"
end
