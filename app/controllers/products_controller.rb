class ProductsController < ApplicationController

  def index
    if params[:q] == "scarce"
      @product = Product.where(cantidad_stock: 1..5).limit(25)
      render json: ProductSerializer.new(@product, {fields: { product: [ :codigo_unico, :descripcion, :detalle, :monto, :cantidad_stock ] } })
    elsif params[:q] == "all"
      @product = Product.all.limit(25)
      render json: ProductSerializer.new(@product, {fields: { product: [ :codigo_unico, :descripcion, :detalle, :monto, :cantidad_stock ] } })
    else
      @product = Product.where(cantidad_stock: 1..Float::INFINITY).limit(25)
      render json: ProductSerializer.new(@product, {fields: { product: [ :codigo_unico, :descripcion, :detalle, :monto, :cantidad_stock ] } })
    end
  end

  # GET /productos 
#  def index
#    render json: ProductSerializer.new(Product.where(cantidad_stock: 1..Float::INFINITY).limit(25))
#  end

  # GET /productos/all
#  def allProducts
#    render json: ProductSerializer.new(Product.all.limit(25))
#  end

  # GET /productos/scarce
#  def scarceProducts
#    render json: ProductSerializer.new(Product.where(cantidad_stock: 1..5).limit(25))
#  end

  # GET /productos/:codigo
  def show
  	@product = Product.find_by(codigo_unico: (params[:codigo]))
    if @product
      render json: ProductSerializer.new(@product, {fields: { product: [ :codigo_unico, :descripcion, :detalle, :monto, :cantidad_stock ] } })
    else
      render status: :not_found
    end
  	
  end

  # GET /productos/:codigo/items
  def showItems
    @product = Product.find_by(codigo_unico: (params[:codigo]))
    if @product
      render json: ProductSerializer.new(@product, { fields: { product: [ :codigo_unico, :descripcion, :cantidad_stock, :estado_y_valor_venta_item ] } })
    else
      render status: :not_found
      #head "404 Not found"
    end
  end


  # POST /productos/:codigo/items
  def create
   @product = Product.find_by(codigo_unico: params[:codigo])
    if @product 
      if params[:items].to_i > 0
        # Crear "params[:items]" nuevos items para el producto
        1.upto(params[:items].to_i) do 
            @product.items.create(valor_venta: 0) 
        end
        #Le suma la cantidad de nuevos items al stock que ya tenía
        @product.update(cantidad_stock: @product.cantidad_stock + params[:items].to_i)
        render json: :ok
        
      else
        render json: "La cantidad de items debe ser mayor a 0"
      end
    else
      render json: :not_found
    end
  end

end
