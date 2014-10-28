class MoviesController < ApplicationController
	def index
      if params[:search] 
           @projects = Movie.find(:all, :conditions => ["name LIKE ?", "%#{params[:search]}%"]) 
          if @projects.size.zero? 
            @projects = Movie.find(:all) 
          end 
      else 
           @projects = Movie.find(:all) 
       end
  end
  def new


      @movie = Movie.new    

  end

  def show
     @current_movie = Movie.find(params[:id])
  end

   def create

    	@movie = Movie.create(params[:movie])
      # raise @movie.inspect
    	if @movie.save
        session[:movie_id] =@movie.id
        
    		flash[:notice] = "Entered Movie  successfully"
        flash[:color]= "valid"


        redirect_to new_movie_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'new'
      end
      
    end

    def edit
      @movie = Movie.find(params[:id])
    end

    def update
      @movie = Movie.find(params[:id])
      # raise @movie.inspect
      if @movie.update_attributes(params[:movie])
        session[:movie_id]=@movie.id
        @current_movie=Movie.find(session[:movie_id])
        flash[:notice] = "Updated  successfully"
        flash[:color]= "valid"
        redirect_to new_movie_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'edit'
      end
      
    end
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to new_movie_path
    end
    

end
