class SessionsController < ApplicationController
 
	before_filter :authenticate_user, :except => [ :login, :login_attempt, :logout]
	before_filter :save_login_state, :only => [ :login, :login_attempt]

	def home
		#Home Page
	end
	def news
	end

	def profile
		@current_user = User.find(session[:user_id])
	end

	def setting
		#Setting Page
	end

	def login
		@title = "login"
	end

	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		#raise authorized_user.inspect

		if authorized_user.nil?
			flash.now[:notice] = "Invalid Username or Password"
        	flash[:color]= "invalid"
			render "login", flash: {error: "Invalid User or Password"}
		else
			session[:user_id] = authorized_user.id

			session[:user_email] = authorized_user.email
			
			
			redirect_to home_path
		end
	end

	def logout
		session[:user_id] = nil
		flash[:notice] = "You have successfully logged out."
		redirect_to login_path
	end

end
