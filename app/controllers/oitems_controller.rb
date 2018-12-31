class OitemsController < ApplicationController
  #need current cart
#need oitem
#before_action :get_oitem
def create
  #view sends us what user wants to put into cart
  product = Product.find(params[:product_id])
  weight = params[:weight]

  #add the stuff to the cart or else create a new cart
  #create a new oitem based on params but an oitem is meaningless on its own--- so create an oitem in the cart based on the params

  #need to get the current cart, helper method in application ctrl
  @cart = current_cart
  puts "in create, product:#{product} , weight:#{weight} cart: #{@cart}"

  #add_product in cart model
  @oitem = @cart.add_product(product, weight)
  if @oitem.save
 puts "\n\n\nin oitem.save"
    #see set_cart_total in cart model
      #set the cart_total and save it
    @cart.set_cart_total(@cart.oitems)
    
    @oitem.cart.save
    puts "oitem cart is : #{@oitem.cart}"
    redirect_to @oitem.cart, notice:'added'
  end
end

def destroy
  #need cart and item (TODD before action for oitem)
  @oitem = Oitem.find(params[:id])
  @cart = Cart.find(session[:cart_id])
  @oitem.destroy

   ##update cart total (TODO this is messy)
   @cart.set_cart_total(@cart.oitems)
   @cart.save

  #refresh page
  redirect_to cart_path(@cart)
end



private

def oitem_params
  params.require(:oitem).permit(:product_id, :weight)
end
# def get_oitem
#   @oitem = Oitem.find(params[:id])
# end
  
end