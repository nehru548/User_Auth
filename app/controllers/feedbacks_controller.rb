class FeedbacksController < ApplicationController
  before_filter :authenticate_user
  def index
      @movies = Movie.search params[:search]
    end
	def new
		@feedback = Feedback.new  
	end
	def show
     @current_feedback = Feedback.find(params[:id])
  	end

   def create

    	@feedback= Feedback.create(params[:feedback])
     
    	if @feedback.save
        session[:feedback_id] =@feedback.id
        
    		flash[:notice] = "Entered feedback  successfully"
        flash[:color]= "valid"


        redirect_to new_feedback_path(:name  =>@feedback.movie_name)
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'new'
      end
      
    end

    def edit
      @feedback= Feedback.find(params[:id])
    end

    def update
       @feedback = Feedback.find(params[:id])
      # raise @feedback.inspect
      if @feedback.update_attributes(params[:feedback])
        session[:feedback_id]=@feedback.id
        @current_feedback=Feedback.find(session[:feedback_id])
        flash[:notice] = "Updated  successfully"
        flash[:color]= "valid"
        redirect_to new_feedback_path(:name =>@feedback.movie_name)
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'edit'
      end
      
    end
    def destroy
      @feedback = Feedback.find(params[:id])
      @feedback.destroy
      redirect_to new_feedback_path(:name =>session[:movie_name])
    end
    def search
      @movies = Movie.search params[:search]
    end
 
end
