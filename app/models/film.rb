class Film < ActiveRecord::Base
	attr_accessible :name, :actors, :description, :director
 	def self.search(search)
  		if search
  			where(['name LIKE ?', "%#{search}%"])
  		else
    		Film.all
  		end
	end 
 
end
