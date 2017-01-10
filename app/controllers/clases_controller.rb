class ClasesController < ApplicationController
  # GET /clases
  # GET /clases.json

  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis

  def index
    @clases = Clase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clases }
    end
  end

  # GET /clases/1
  # GET /clases/1.json
  def show
    @clase = Clase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clase }
    end
  end

  # GET /clases/new
  # GET /clases/new.json
  def new
    @clase = Clase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clase }
    end
  end

  # GET /clases/1/edit
  def edit
    @clase = Clase.find(params[:id])
  end

  # POST /clases
  # POST /clases.json
  def create
    @clase = Clase.new(params[:clase])

    respond_to do |format|
      if @clase.save
        format.html { redirect_to @clase, notice: 'Clase was successfully created.' }
        format.json { render json: @clase, status: :created, location: @clase }
      else
        format.html { render action: "new" }
        format.json { render json: @clase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clases/1
  # PUT /clases/1.json
  def update
    @clase = Clase.find(params[:id])

    respond_to do |format|
      if @clase.update_attributes(params[:clase])
        format.html { redirect_to @clase, notice: 'Clase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clases/1
  # DELETE /clases/1.json
  def destroy
    @clase = Clase.find(params[:id])
    @clase.destroy

    respond_to do |format|
      format.html { redirect_to clases_url }
      format.json { head :no_content }
    end
  end
end
