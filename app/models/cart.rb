class Cart < ApplicationRecord
  belongs_to :user, optional: :true
  has_many :oitems, dependent: :destroy

  def add_product(product, weight)

     #get oitem total
     total = product.price * weight.to_f
     total = total.to_f
   
    #find the product by id
    #check if it's in this cart already and change weight 
    #if not there create a new oitem inside the cart
    the_item = oitems.find_by(product_id:product.id)
    if(the_item)

      #update needs(id, updates), seems it doent need id
      the_item.update( :weight => weight, total:total)
     
    else
      #use collection.build
      # "collection.build(attributes = {}, …) Returns one or more new objects of the collection type that have been instantiated with attributes and linked to this object through a foreign key, but have not yet been saved. Note: This only works if an associated object already exists, not if it‘s nil!"
      the_item = oitems.build(product_id:product.id, weight:weight, total:total)
    end

    return the_item
  end

  def set_cart_total(oitems)
    cart_total = 0

    oitems.each do |i|
      cart_total += i.total
    end
    
    self[:cart_total] = cart_total
  end

  def add_payment_to_cart(token, id)
    cart = Cart.find(id)
    cart.update( :status => token, :paid => true)
  
    #session hash not available in models!!
    #session.delete(:cart_id)
  end




end
