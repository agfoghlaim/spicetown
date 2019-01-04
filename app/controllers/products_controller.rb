class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:index,:show]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @cart =  current_cart
    puts "current cart is #{@cart}"
  end

  def filter_products

    #get products in this cat
    category = Category.find(params[:category_id])
    @products = category.products
    
    #re render view to update
    render :index

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.categories.build
  end

  # GET /products/1/edit
  def edit
    puts params
    puts "/n/n/n/n here:#{params[:categories_attributes]}"
    @product.categories.build
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    puts "/n/n/n/n oh:#{params[:product][:categories_attributes]}"
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :price,:productimg,
        categories_attributes: [:id, :title, :_destroy],
    category_ids: [])
    end
end
