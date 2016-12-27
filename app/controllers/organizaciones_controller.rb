# encoding: UTF-8
class OrganizacionesController < ApplicationController
  # GET /organizaciones
  # GET /organizaciones.json

  before_filter :filtro_logueado
  def index
    if params[:clientes]
      @organizaciones = Organizacion.clientes.order(['interna_id DESC'])
      @titulo = "Clientes"
    else
      @organizaciones = Organizacion.order(['interna_id DESC'])
      @titulo = "Organizaciones"
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizaciones }
    end
  end

  # GET /organizaciones/1
  # GET /organizaciones/1.json
  def show
    @organizacion = Organizacion.find(params[:id])
    @actor = Actor.new
    @actor.organizacion_id = @organizacion.id
    @marca = Marca.new
    @producto = Producto.new
    @marca.organizacion_id = @organizacion.id
    @medio_organizacion = MedioOrganizacion.new
    @medio_organizacion.organizacion_id = @organizacion.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organizacion }
    end
  end

  # GET /organizaciones/new
  # GET /organizaciones/new.json
  def new
    @organizacion = Organizacion.new
    if params[:entorno_id]
      @organizacion.entorno_id = params[:entorno_id]
      @entorno = true
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organizacion }
    end
  end

  # GET /organizaciones/1/edit
  def edit
    @organizacion = Organizacion.find(params[:id])
    if params[:entorno_id]
      @organizacion.entorno_id = params[:entorno_id]
      @entorno = true
    end
  end

  # POST /organizaciones
  # POST /organizaciones.json
  def create
    @organizacion = Organizacion.new(params[:organizacion])

    respond_to do |format|
      if @organizacion.save
        if params[:entorno]
          format.html { redirect_to entorno_path(@organizacion.entorno), notice: 'Organizacion registrada con éxito.' }
        else
          format.html { redirect_to @organizacion, notice: 'Organizacion registrada con éxito.' }
        end
        format.json { render json: @organizacion, status: :created, location: @organizacion }
      else
        format.html { render action: "new" }
        format.json { render json: @organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /organizaciones/1
  # PUT /organizaciones/1.json
  def update
    @organizacion = Organizacion.find(params[:id])

    respond_to do |format|
      if @organizacion.update_attributes(params[:organizacion])
        if params[:entorno]
          format.html { redirect_to entorno_path(@organizacion.entorno), notice: 'Organizacion registrada con éxito.' }
        else
          format.html { redirect_to @organizacion, notice: 'Organizacion registrada con éxito.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizaciones/1
  # DELETE /organizaciones/1.json
  def destroy
    @organizacion = Organizacion.find(params[:id])
    @entorno = @organizacion.entorno if params[:entorno]
    @organizacion.destroy

    respond_to do |format|
      if params[:entorno]
        format.html { redirect_to entorno_path(@entorno), notice: 'Organización Eliminada' }
      else
        format.html { redirect_to organizaciones_url, notice: 'Organización Eliminada' }
      end
      format.json { head :no_content }
    end
  end
end
