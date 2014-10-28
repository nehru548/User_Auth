class News < ActiveRecord::Base
	def self.search(search)
  		if search
  			where(['name LIKE ?', "%#{search}%"])
  		else
    		News.all
  		end
	end
end
