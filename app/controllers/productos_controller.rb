# encoding: UTF-8
class ProductosController < ApplicationController
  # GET /productos
  # GET /productos.json
  def index
    @productos = Producto.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @productos }
    end
  end

  # GET /productos/1
  # GET /productos/1.json
  def show
    @producto = Producto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/new
  # GET /productos/new.json
  def new
    @producto = Producto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producto }
    end
  end

  # GET /productos/1/edit
  def edit
    @producto = Producto.find(params[:id])
  end

  # POST /productos
  # POST /productos.json


  def create

    producto = params[:producto]
    palabras = producto[:nombre].split(";")
    errores = ""
    total = 0
    palabras.each_with_index do |pa,i|
      producto[:nombre] = producto[:descripcion] = pa
      begin
        obj = Producto.new(producto)
        obj.save
        total += 1
      rescue Exception => e
        errores = "error en la palabra #{i+1}:< #{e} > |"
      end

    end
    mensaje = "Total de palabras: #{total}. "
      
    mensaje += "Errores: #{errores}" unless (errores.eql? '')

    redirect_to productos_path, notice: mensaje

  end

  # PUT /productos/1
  # PUT /productos/1.json
  def update
    @producto = Producto.find(params[:id])

    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to @producto, notice: 'Producto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.json
  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy

    respond_to do |format|
      format.html { redirect_to productos_url }
      format.json { head :no_content }
    end
  end
end
