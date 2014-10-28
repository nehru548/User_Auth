  class UsersController < ApplicationController

  before_filter :save_login_state , :only => [:create]

  def new
      #Signup Form
      @user = User.new     
  end

  def show
     @current_user = User.find(params[:id])
  end

   def create
    	@user = User.create(params[:user])
      # raise @user.inspect
    	if @user.save
        session[:user_id] =@user.id
        session[:user_email] = @user.email
    		flash[:notice] = "You Signed up successfully"
        flash[:color]= "valid"
        require 'net/smtp'

message = <<MESSAGE_END
From: onlinemovietickets@outlook.com
To: A Test User 
Subject: Online Movie Tickets

You Registerd successfully
MESSAGE_END

smtp = Net::SMTP.new('smtp.gmail.com', 587 )
smtp.enable_starttls
smtp.start('gmail.com', 'online.movie.tickets.booking@gmail.com', 'onlinemovie', :login) do |smtp|
        smtp.send_message message  , 'online.movie.tickets.booking@gmail.com' , @user.email
end
        redirect_to home_path
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'new'
      end
      
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      # raise @user.inspect
      if @user.update_attributes(params[:user])
        session[:user_id]=@user.id
        @current_user=User.find(session[:user_id])
        flash[:notice] = "Updated  successfully"
        flash[:color]= "valid"
        redirect_to user_path(@current_user)
      else
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render 'edit'
      end
      
    end

end
