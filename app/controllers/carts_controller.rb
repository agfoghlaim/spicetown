class CartsController < ApplicationController
  def index
    @cart = Cart.find(params[:id])
  end

  def show
    @cart = Cart.find(params[:id])
  end

    ##for now i'm adding a button_to to cart show view to call this
    def associate_user_with_cart
      @cart = Cart.find(params[:id])
      #at this point check if the user is signed in 
      #if not make them sign in
  
      #need to assosiate the cart with the user
      #also add the users addresses if not different
  
      #paid won't change until payment
      
      if(current_user)
        #update cart current_user is devise helper
        @cart.update(:user_id => current_user.id)
        redirect_to new_charge_path
        #will redirect to charges/new view here
      else
        #redirect to login path
        redirect_to new_user_registration_path
      end
  
    end

    
end