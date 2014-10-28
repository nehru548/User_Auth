class Center < ActiveRecord::Base
	 belongs_to :movie
  has_many :booking
  attr_accessible :name, :movie_id
end
