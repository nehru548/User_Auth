class CentersController < ApplicationController
	def new
      @center = Center.new     
  end

  def show
     @current_center = Center.find(params[:id])
  end

   def create
    	@center = Center.create(params[:center])
      # raise @center.inspect
    	if @center.save
        session[:center_id] =@center.id
        
    		flash[:notice] = "Entered center  successfully"
        flash[:color]= "valid"


        redirect_to new_center_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'new'
      end
      
    end

    def edit
      @center = Center.find(params[:id])
    end

    def update
      @center = Center.find(params[:id])
      # raise @center.inspect
      if @center.update_attributes(params[:center])
        session[:center_id]=@center.id
        @current_center=Center.find(session[:center_id])
        flash[:notice] = "Updated  successfully"
        flash[:color]= "valid"
        redirect_to new_center_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'edit'
      end
      
    end
    def destroy
      @center = Center.find(params[:id])
      @center.destroy
      redirect_to new_center_path
    end
end
