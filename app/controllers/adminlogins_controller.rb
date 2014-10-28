class AdminloginsController < ApplicationController
	before_filter :authenticate_admin, :except => [ :login, :admin_login_attempt, :logout]
	before_filter :save_login_state, :only => [:index, :login, :login_attempt]

	def home
		#Home Page
	end
	def news
	end

	def profile
		@current_admin = Admin.find(session[:admin_id])
	end

	def setting
		#Setting Page
	end

	def login
		@title = "login"
	end
	def admin_login_attempt
		authorized_admin = Admin.authenticate(params[:username_or_email],params[:login_password])
		#raise authorized_admin.inspect

		if authorized_admin.nil?
			flash.now[:notice] = "Invalid adminname or Password"
        	flash[:color]= "invalid"
			render "login", flash: {error: "Invalid admin or Password"}
		else
			session[:admin_id] = authorized_admin.id
			session[:admin_email] = authorized_admin.email
			redirect_to home_path
		end
	end

	def logout
		session[:admin_id] = nil
		flash[:notice] = "You have successfully logged out."
		redirect_to admin_login_path
	end
end
