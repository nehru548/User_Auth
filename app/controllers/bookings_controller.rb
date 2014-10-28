class BookingsController < ApplicationController
  before_filter :authenticate_user
  def index
    @booking=Booking.new
  end
   
  def new
  	@booking = Booking.new
  end

  def create
  	@booking = Booking.create(params[:booking])
    if @booking.save
      session[:booking_id]=@booking.id
      @current_booking=Booking.find(session[:booking_id])
      session[:movie_id]=@current_booking.movie_id
      current_movie= Movie.find(session[:movie_id])

      session[:center_id]=@current_booking.center_id
      current_center= Center.find(session[:center_id])
     if @booking.no_tickets

        @booked_tickets=Ticket.where(:movie_name =>current_movie.name ,:center_name =>current_center.name).sum(:no_tickets)
       @booked_tickets=200-@booked_tickets
       #raise params.inspect
       num=@booked_tickets-@booking.no_tickets
        if  num>=0
         flash[:notice]="more #{num} tickets left"
          redirect_to booking_path(@current_booking)

        else
         flash[:notice]="Only #{@booked_tickets} tickets left"
         redirect_to edit_booking_path(@current_booking)

        end
     else

     end
   else 
    render "edit"
   end
  end

  def show
     @current_booking = Booking.find(params[:id])
  	
  end
  def edit
      @booking = Booking.find(params[:id])
    end

    def update
      @booking = Booking.find(params[:id])
    if @booking.update_attributes(params[:booking])
      # raise @user.inspect
      
    session[:booking_id]=@booking.id
      @current_booking=Booking.find(session[:booking_id])
      session[:movie_id]=@current_booking.movie_id
      current_movie= Movie.find(session[:movie_id])

      session[:center_id]=@current_booking.center_id
      current_center= Center.find(session[:center_id])
     if @booking.no_tickets

        @booked_tickets=Ticket.where(:movie_name =>current_movie.name ,:center_name =>current_center.name).sum(:no_tickets)
       @booked_tickets=200-@booked_tickets
       #raise params.inspect
       num=@booked_tickets-@booking.no_tickets
        if  num>=0
         flash[:notice]="more #{num} tickets left"
          redirect_to booking_path(@current_booking)

        else
         flash[:notice]="Only #{@booked_tickets} tickets left"
         redirect_to edit_booking_path(@current_booking)

        end
     else

     end
   else 
    render "edit"
   end
    end
end
