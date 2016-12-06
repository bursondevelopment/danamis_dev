class MedioOrganizacionesController < ApplicationController
  # GET /medio_organizaciones
  # GET /medio_organizaciones.json
  def index
    @medio_organizaciones = MedioOrganizacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medio_organizaciones }
    end
  end

  # GET /medio_organizaciones/1
  # GET /medio_organizaciones/1.json
  def show
    @medio_organizacion = MedioOrganizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medio_organizacion }
    end
  end

  # GET /medio_organizaciones/new
  # GET /medio_organizaciones/new.json
  def new
    @medio_organizacion = MedioOrganizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medio_organizacion }
    end
  end

  # GET /medio_organizaciones/1/edit
  def edit
    @medio_organizacion = MedioOrganizacion.find(params[:id])
  end

  # POST /medio_organizaciones
  # POST /medio_organizaciones.json
  def create
    @medio_organizacion = MedioOrganizacion.new(params[:medio_organizacion])

    respond_to do |format|
      if @medio_organizacion.save
        format.html { redirect_to @medio_organizacion, notice: 'Medio organizacion was successfully created.' }
        format.json { render json: @medio_organizacion, status: :created, location: @medio_organizacion }
      else
        format.html { render action: "new" }
        format.json { render json: @medio_organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medio_organizaciones/1
  # PUT /medio_organizaciones/1.json
  def update
    @medio_organizacion = MedioOrganizacion.find(params[:id])

    respond_to do |format|
      if @medio_organizacion.update_attributes(params[:medio_organizacion])
        format.html { redirect_to @medio_organizacion, notice: 'Medio organizacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medio_organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medio_organizaciones/1
  # DELETE /medio_organizaciones/1.json
  def destroy
    @medio_organizacion = MedioOrganizacion.find(params[:id])
    @medio_organizacion.destroy

    respond_to do |format|
      format.html { redirect_to medio_organizaciones_url }
      format.json { head :no_content }
    end
  end
end
