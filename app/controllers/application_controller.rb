class ApplicationController < ActionController::Base

  helper_method :current_cart
  before_action :get_all_categories

  #for devise controllers, set cart 'the lazy way'
  #before_action :get_current_cart, if: :devise_controller?
  before_action :get_current_cart
  
  protected

  def get_current_cart
    @cart = current_cart
  end
  
  def current_cart
    #does a cart already exist? - use session var to find out
  
    #find either returns the cart or raises ActiveRecord::RecordNotFound exception so

    #first check if it exists, exists returns bool
    if(Cart.exists?(session[:cart_id]))
      #it exists, so find it (this doesn't seem like the most efficient way of doing this)

      #find cart for current session id
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create

      #set cart id so findable
      session[:cart_id] = @cart.id
    end
    return @cart

  end

  def clear_cart
    session.delete(:cart_id)
    #session[:cart_id] = @cart.id
  end

  #for category sidebar
  def get_all_categories
    @all_categories = Category.all
  end

  
end
