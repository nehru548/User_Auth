class FilmsController < ApplicationController
	def index
      @films = Film.search params[:search]
  end
  def new


      @film = Film.new    

  end

  def show
     @film = Film.all
  end

   def create

    	@film = Film.create(params[:film])
      # raise @film.inspect
    	if @film.save
        session[:film_id] =@film.id
        
    		flash[:notice] = "Entered film  successfully"
        flash[:color]= "valid"


        redirect_to new_film_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'new'
      end
      
    end

    def edit
      @film = Film.find(params[:id])
    end

    def update
      @film = Film.find(params[:id])
      # raise @film.inspect
      if @film.update_attributes(params[:film])
        session[:film_id]=@film.id
        @current_film=Film.find(session[:film_id])
        flash[:notice] = "Updated  successfully"
        flash[:color]= "valid"
        redirect_to new_film_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'edit'
      end
      
    end
    def destroy
      @film = Film.find(params[:id])
      @film.destroy
      redirect_to new_film_path
    end
end
