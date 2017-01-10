# encoding: UTF-8
class MarcasController < ApplicationController
  # GET /marcas
  # GET /marcas.json
  before_filter :filtro_logueado
  before_filter :filtro_logueado_admin

  def index
    @marcas = Marca.order('nombre ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @marcas }
    end
  end

  # GET /marcas/1
  # GET /marcas/1.json
  def show
    @marca = Marca.find(params[:id])
    @producto = Producto.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @marca }
    end
  end

  # GET /marcas/new
  # GET /marcas/new.json
  def new
    @marca = Marca.new
    @clientes = Organizacion.clientes
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @marca }
    end
  end

  # GET /marcas/1/edit
  def edit
    @marca = Marca.find(params[:id])
    @clientes = Organizacion.clientes
  end

  # POST /marcas
  # POST /marcas.json
  def create
    @marca = Marca.new(params[:marca])

    respond_to do |format|
      if @marca.save
        format.html { redirect_to @marca, notice: 'Marca registrada con éxito.' }
        format.json { render json: @marca, status: :created, location: @marca }
      else
#        @clientes = Organizacion.clientes
        format.html { render action: "new"}
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /marcas/1
  # PUT /marcas/1.json
  def update
    @marca = Marca.find(params[:id])

    respond_to do |format|
      if @marca.update_attributes(params[:marca])
        format.html { redirect_to @marca, notice: 'Marca actualizada con éxito.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marcas/1
  # DELETE /marcas/1.json
  def destroy
    @marca = Marca.find(params[:id])
    @marca.destroy

    respond_to do |format|
      format.html { redirect_to marcas_url }
      format.json { head :no_content }
    end
  end
end
