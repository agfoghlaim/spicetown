class CategoriesController < ApplicationController

  def get_products
    @category = Category.find(params[:category_id])

    #products with this category id
    products = @category.products
    @products = @category.products
    #init array, will need to add product details from product table as well as product img url from the active storage attachments table
    to_send = []
   
      products.each do |product|
        if product.productimg.attached?

        #get the img url
        img_url = 
        Rails.application.routes.url_helpers.rails_blob_path(product.productimg, only_path: true)

        #add product and img dets to array
        to_send.push(:product => product, :img_url => img_url)
      end

    end
    #puts "\n\n\n to send: #{to_send}"
 #redirect_to get_products

  respond_to do |format|
    #respons to js request for homepage
   format.json { render :json => to_send }
  
    #so regular page works too
    
  end
   end


  def index
    @categories = Category.all
  end

  def new
    
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    #render plain: params[:category].inspect
    @category = Category.new(category_params)
    if(@category.save)
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if(@category.update(category_params))
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:title,
      products_attributes: [:id, :title, :_destroy, :productimg],
      prodcats_attributes: [:category_id, :product_id, :_destroy] )
  end

  
end
