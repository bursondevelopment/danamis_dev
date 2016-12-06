class MediosController < ApplicationController
  # GET /medios
  # GET /medios.json
  def index
    @medios = Medio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medios }
    end
  end

  # GET /medios/1
  # GET /medios/1.json
  def show
    @medio = Medio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medio }
    end
  end

  # GET /medios/new
  # GET /medios/new.json
  def new
    @medio = Medio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medio }
    end
  end

  # GET /medios/1/edit
  def edit
    @medio = Medio.find(params[:id])
  end

  # POST /medios
  # POST /medios.json
  def create
    @medio = Medio.new(params[:medio])

    respond_to do |format|
      if @medio.save
        format.html { redirect_to @medio, notice: 'Medio was successfully created.' }
        format.json { render json: @medio, status: :created, location: @medio }
      else
        format.html { render action: "new" }
        format.json { render json: @medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medios/1
  # PUT /medios/1.json
  def update
    @medio = Medio.find(params[:id])

    respond_to do |format|
      if @medio.update_attributes(params[:medio])
        format.html { redirect_to @medio, notice: 'Medio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medios/1
  # DELETE /medios/1.json
  def destroy
    @medio = Medio.find(params[:id])
    @medio.destroy

    respond_to do |format|
      format.html { redirect_to medios_url }
      format.json { head :no_content }
    end
  end
end
