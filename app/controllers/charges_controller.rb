class ChargesController < ApplicationController

  def new
    #will need a display amt and an amt in cents
    #will need access to cart total, use helper in application ctrl
    @amount = (current_cart.cart_total*100).to_i

   
  end
  
  def create
    #@cart =  current_cart
    # Amount in cents, will need display amount too
     @amount = (current_cart.cart_total*100).to_i
     puts "amt is : #{@amount} and: #{@cart}"
     
  
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'eur'
    )
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
    
  end
  

  
end
