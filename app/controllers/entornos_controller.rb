class EntornosController < ApplicationController
  # GET /entornos
  # GET /entornos.json
  def index
    @entornos = Entorno.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entornos }
    end
  end

  # GET /entornos/1
  # GET /entornos/1.json
  def show
    @entorno = Entorno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entorno }
    end
  end

  # GET /entornos/new
  # GET /entornos/new.json
  def new
    @entorno = Entorno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entorno }
    end
  end

  # GET /entornos/1/edit
  def edit
    @entorno = Entorno.find(params[:id])
  end

  # POST /entornos
  # POST /entornos.json
  def create
    @entorno = Entorno.new(params[:entorno])

    respond_to do |format|
      if @entorno.save
        format.html { redirect_to @entorno, notice: 'Entorno was successfully created.' }
        format.json { render json: @entorno, status: :created, location: @entorno }
      else
        format.html { render action: "new" }
        format.json { render json: @entorno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entornos/1
  # PUT /entornos/1.json
  def update
    @entorno = Entorno.find(params[:id])

    respond_to do |format|
      if @entorno.update_attributes(params[:entorno])
        format.html { redirect_to @entorno, notice: 'Entorno was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entorno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entornos/1
  # DELETE /entornos/1.json
  def destroy
    @entorno = Entorno.find(params[:id])
    @entorno.destroy

    respond_to do |format|
      format.html { redirect_to entornos_url }
      format.json { head :no_content }
    end
  end
end
