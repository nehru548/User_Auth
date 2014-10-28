class OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  def create
  @order = Order.create(params[:order])
    if @order.save
       @current_user= User.find(session[:user_id])
      @current_movie= Movie.find(session[:movie_id])
      @current_center= Center.find(session[:center_id])
       @current_booking= Booking.find(session[:booking_id])
 
      
    
      @ticket=Ticket.create
      @ticket.username=@current_user.username
      @ticket.movie_name=@current_movie.name
      @ticket.center_name=@current_center.name
      @ticket.date=@current_booking.date
      @ticket.time=@current_booking.time
      @ticket.no_tickets=@current_booking.no_tickets
      @ticket.price=@ticket.no_tickets*12
      @booked_tickets=Ticket.where(:movie_name =>@current_movie.name ,:center_name =>@current_center.name,:date =>@current_booking.date,:time =>@current_booking.time).sum(:no_tickets)
     
      @seat=[]
       for a in @booked_tickets+1..@booked_tickets+@ticket.no_tickets
          @seat<<a
       end
       @ticket.seat_number=@seat.join(',')
       
      @ticket.save
      session[:ticket_id]=@ticket.id
      @k=session[:image]
      require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/ascii_outputter'
require 'barby/outputter/png_outputter'
 
barcode = Barby::Code128B.new(@ticket.id) 
File.open('/Sites/User_Auth/app/assets/images/barcode.png', 'wb'){|f| 

  f.write barcode.to_png(:margin => 3, :xdim => 2, :height => 55) 
} 


       require 'net/smtp'

message = <<MESSAGE_END
From: onlinemovietickets@outlook.com
To: A Test User 
Content-type: text/html
Subject: Online Movie Tickets
attachments['barcode.png'] = File.read('../assets/images/barcode.png')
 

This is an e-mail message to be sent in HTML format
#{@k}


<h1>You  successfully booked for  #{@ticket.movie_name} Movie</h1>
<h2>
<table align='center' border="1">
<tr>
<th>Ticket Id</th>
<td>#{@ticket.id}</td>
</tr>
<tr>
<th>Movie name</th>
<td>#{@ticket.movie_name}</td>
</tr>
<tr>
<th>Center Name</th>
<td>#{@ticket.center_name}</td>
</tr>
<tr>
<th>Date</th>
<td>#{@ticket.date}</td>
</tr>
<tr>
<th>time</th>
<td>#{@ticket.time}</td>
</tr>
<tr>
<th>Number of Tickets</th>
<td>#{@ticket.no_tickets}</td>
</tr>
<tr>
<th>Seat Numbers</th>
<td>#{@seat.join(", ")}
</td>
</tr>
<tr>
<th>Price</th>
<t<td>$#{@ticket.price}</td>
</td>
</tr>


</table>
<img src='http://0.0.0.0:3000/barcode.png'>

</h2>


MESSAGE_END

smtp = Net::SMTP.new('smtp.gmail.com', 587 )
smtp.enable_starttls
smtp.start('gmail.com', 'online.movie.tickets.booking@gmail.com', 'onlinemovie', :login) do |smtp|
        smtp.send_message message  , 'online.movie.tickets.booking@gmail.com' , @current_user.email
end


      redirect_to order_path(@order),:notice => "Successfully Done"
    else
      render :new
    end

end
def save_with_payment
  if valid?
    customer = Stripe::Customer.create(description:nehru, booking_id: booking_id, card: stripe_card_token)
    self.stripe_customer_token = customer.id
    save!
  end
rescue Stripe::InvalidRequestError => e
  logger.error "Stripe error while creating customer: #{e.message}"
  errors.add :base, "There was a problem with your credit card."
end
end
