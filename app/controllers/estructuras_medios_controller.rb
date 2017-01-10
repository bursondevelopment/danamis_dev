# encoding: UTF-8
class EstructurasMediosController < ApplicationController

  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis

  # GET /estructuras_medios
  # GET /estructuras_medios.json
  def index
    @estructuras_medios = EstructuraMedio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @estructuras_medios }
    end
  end

  # GET /estructuras_medios/1
  # GET /estructuras_medios/1.json
  def show
    @estructura_medio = EstructuraMedio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @estructura_medio }
    end
  end

  # GET /estructuras_medios/new
  # GET /estructuras_medios/new.json
  def new
    @estructura_medio = EstructuraMedio.new
    @estructura_medio.medio_id = @medio_id = params[:medio_id] if params[:medio_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @estructura_medio }
    end
  end

  # GET /estructuras_medios/1/edit
  def edit
    @estructura_medio = EstructuraMedio.find(params[:id])
    @medio_id = params[:medio_id] if params[:medio_id]

  end

  # POST /estructuras_medios
  # POST /estructuras_medios.json
  def create
    @estructura_medio = EstructuraMedio.new(params[:estructura_medio])

    respond_to do |format|
      if @estructura_medio.save
        if params[:medio_id]
          format.html { redirect_to medio_path(params[:medio_id]), notice: 'Estructura medio cargada con éxito.' }
        else
          format.html { redirect_to @estructura_medio, notice: 'Estructura medio cargada con éxito.' }
          format.json { render json: @estructura_medio, status: :created, location: @estructura_medio }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @estructura_medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /estructuras_medios/1
  # PUT /estructuras_medios/1.json
  def update
    @estructura_medio = EstructuraMedio.find(params[:id])

    respond_to do |format|
      if @estructura_medio.update_attributes(params[:estructura_medio])
        if params[:medio_id]
          format.html { redirect_to medio_path(params[:medio_id]), notice: 'Estructura medio actualizada con éxito.' }
#          format.json { render json: @estructura_medio, status: :created, location: @estructura_medio }
        else
          format.html { redirect_to @estructura_medio, notice: 'Estructura medio actualizada con éxito.' }
          format.json { render json: @estructura_medio, status: :created, location: @estructura_medio }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @estructura_medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estructuras_medios/1
  # DELETE /estructuras_medios/1.json
  def destroy
    @estructura_medio = EstructuraMedio.find(params[:id])
    @estructura_medio.destroy

    respond_to do |format|
        redirect_path = params[:medio_id] ? medio_path(params[:medio_id]) : estructuras_medios_url 
        format.html { redirect_to redirect_path, notice: 'Estructura Eliminada.' } 
        format.json { head :no_content }
    end
  end
end
