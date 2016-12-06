class EstructurasMediosController < ApplicationController
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @estructura_medio }
    end
  end

  # GET /estructuras_medios/1/edit
  def edit
    @estructura_medio = EstructuraMedio.find(params[:id])
  end

  # POST /estructuras_medios
  # POST /estructuras_medios.json
  def create
    @estructura_medio = EstructuraMedio.new(params[:estructura_medio])

    respond_to do |format|
      if @estructura_medio.save
        format.html { redirect_to @estructura_medio, notice: 'Estructura medio was successfully created.' }
        format.json { render json: @estructura_medio, status: :created, location: @estructura_medio }
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
        format.html { redirect_to @estructura_medio, notice: 'Estructura medio was successfully updated.' }
        format.json { head :no_content }
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
      format.html { redirect_to estructuras_medios_url }
      format.json { head :no_content }
    end
  end
end
