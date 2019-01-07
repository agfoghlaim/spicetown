class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :associate_user_with_cart]
 

  def show
    #@cart = Cart.find(params[:id])
  end

  def edit
  end

  def update
    
 

    @cart.update(
      :status => params[:status])
    
    if @cart.update(cart_params)
      redirect_to new_charge_path, notice: "Order saved"
    else
      render 'edit'
    end
  end

    ##for now i'm adding a button_to to cart show view to call this
    def associate_user_with_cart
      #@cart = Cart.find(params[:id])
      
      #at this point check if the user is signed in 
      #if not make them sign in
  
      #need to assosiate the cart with the user
      #also add the users addresses (they have option to change them in next step when this redirects to edit_cart_path)
  
      #paid won't change until payment
      
      if(current_user)
        #update cart current_user is devise helper
        @cart.update(
          :user_id => current_user.id, 
          :billing => current_user.billing_address,
          :shipping => current_user.shipping_address)
        
        #will redirect to charges/new view here
        #redirect_to new_charge_path

        #first they need to go to edit cart
        redirect_to edit_cart_path(@cart)
      else
        #redirect to login path
        redirect_to new_user_registration_path
      end
  
    end

    private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.require(:cart).permit(:billing, :shipping, :status)
    end

    
end