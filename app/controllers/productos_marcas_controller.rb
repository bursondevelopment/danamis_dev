# encoding: UTF-8
class ProductosMarcasController < ApplicationController
  # GET /productos_marcas
  # GET /productos_marcas.json
  def index
    @productos_marcas = ProductoMarca.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productos_marcas }
    end
  end

  # GET /productos_marcas/1
  # GET /productos_marcas/1.json
  def show
    @producto_marca = ProductoMarca.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producto_marca }
    end
  end

  # GET /productos_marcas/new
  # GET /productos_marcas/new.json
  def new
    @producto_marca = ProductoMarca.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producto_marca }
    end
  end

  # GET /productos_marcas/1/edit
  def edit
    @producto_marca = ProductoMarca.find(params[:id])
  end

  # POST /productos_marcas
  # POST /productos_marcas.json
  def create
    @producto_marca = ProductoMarca.new(params[:producto_marca])

    respond_to do |format|
      if @producto_marca.save
        format.html { redirect_to @producto_marca, notice: 'Producto Marca Registrado con éxito.' }
        format.json { render json: @producto_marca, status: :created, location: @producto_marca }
        @marca = @producto_marca.marca
        @productos = @producto_marca.productos
        format.js { render @productos, status: :created, location: @productos}
      else
        format.html { render action: "new" }
        format.json { render json: @producto_marca.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_remote
    1/0
    @marca = Marca.find(params[:id])

    @producto_marca = ProductoMarca.new(params[:pm])
    #@producto = @marca.productos.create(params[:producto])
      
    respond_to do |format|
      if @producto_marca.save 
        format.html {redirect_to :back}
        format.js {render js: @producto}
      else
      end
    end
  end

  # PUT /productos_marcas/1
  # PUT /productos_marcas/1.json
  def update
    @producto_marca = ProductoMarca.find(params[:id])

    respond_to do |format|
      if @producto_marca.update_attributes(params[:producto_marca])
        format.html { redirect_to @producto_marca, notice: 'Producto Marca Actualizado.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @producto_marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos_marcas/1
  # DELETE /productos_marcas/1.json
  def destroy
    @producto_marca = ProductoMarca.find(params[:id])
    @producto_marca.destroy

    respond_to do |format|
      format.html { redirect_to productos_marcas_url }
      format.json { head :no_content }
    end
  end
end
