# encoding: UTF-8
class TiposMediosController < ApplicationController
  # GET /tipos_medios
  # GET /tipos_medios.json
  def index
    @tipos_medios = TipoMedio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipos_medios }
    end
  end

  # GET /tipos_medios/1
  # GET /tipos_medios/1.json
  def show
    @tipo_medio = TipoMedio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_medio }
    end
  end

  # GET /tipos_medios/new
  # GET /tipos_medios/new.json
  def new
    @tipo_medio = TipoMedio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_medio }
    end
  end

  # GET /tipos_medios/1/edit
  def edit
    @tipo_medio = TipoMedio.find(params[:id])
  end

  # POST /tipos_medios
  # POST /tipos_medios.json
  def create
    @tipo_medio = TipoMedio.new(params[:tipo_medio])

    respond_to do |format|
      if @tipo_medio.save
        format.html { redirect_to @tipo_medio, notice: 'Tipo medio registrado con éxito.' }
        format.json { render json: @tipo_medio, status: :created, location: @tipo_medio }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipos_medios/1
  # PUT /tipos_medios/1.json
  def update
    @tipo_medio = TipoMedio.find(params[:id])

    respond_to do |format|
      if @tipo_medio.update_attributes(params[:tipo_medio])
        format.html { redirect_to @tipo_medio, notice: 'Tipo medio actualizado con éxito.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_medios/1
  # DELETE /tipos_medios/1.json
  def destroy
    @tipo_medio = TipoMedio.find(params[:id])
    @tipo_medio.destroy

    respond_to do |format|
      format.html { redirect_to tipos_medios_url }
      format.json { head :no_content }
    end
  end
end
