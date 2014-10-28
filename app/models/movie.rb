class Movie < ActiveRecord::Base
	 has_many :centers
  	 has_many :booking
  	 attr_accessible :name
  	def self.search(search)
  		if search
  			where(['name LIKE ?', "%#{search}%"])
  		else
    		Movie.all
  		end
	end
end
