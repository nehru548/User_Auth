class Trailer < ActiveRecord::Base
	def self.search(search)
  		if search
  			where(['name LIKE ?', "%#{search}%"])
  		else
    		Trailer.all
  		end
	end
end
