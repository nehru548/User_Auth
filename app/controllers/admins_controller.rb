class AdminsController < ApplicationController
	
	 before_filter :save_login_state , :only => [:create]

  def new
      #Signup Form
      @admin = Admin.new     
  end

  def show
     @current_admin = Admin.find(params[:id])
  end

   def create
    	@admin = Admin.create(params[:admin])
      # raise @admin.inspect
    	if @admin.save
        session[:admin_id] =@admin.id
        session[:admin_email] = @admin.email
    		flash[:notice] = "You Signed up successfully"
        flash[:color]= "valid"
        
        redirect_to home_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'new'
      end
      
    end

    def edit
      @admin = Admin.find(params[:id])
    end

    def update
      @admin = Admin.find(params[:id])
      # raise @admin.inspect
      if @admin.update_attributes(params[:admin])
        session[:admin_id]=@admin.id
        @current_admin=Admin.find(session[:admin_id])
        flash[:notice] = "Updated  successfully"
        flash[:color]= "valid"
        redirect_to admin_path(@current_admin)
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'edit'
      end
      
    end
end
