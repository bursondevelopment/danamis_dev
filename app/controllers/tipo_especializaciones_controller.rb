class TipoEspecializacionesController < ApplicationController
  # GET /tipo_especializaciones
  # GET /tipo_especializaciones.json
  def index
    @tipo_especializaciones = TipoEspecializacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_especializaciones }
    end
  end

  # GET /tipo_especializaciones/1
  # GET /tipo_especializaciones/1.json
  def show
    @tipo_especializacion = TipoEspecializacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_especializacion }
    end
  end

  # GET /tipo_especializaciones/new
  # GET /tipo_especializaciones/new.json
  def new
    @tipo_especializacion = TipoEspecializacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_especializacion }
    end
  end

  # GET /tipo_especializaciones/1/edit
  def edit
    @tipo_especializacion = TipoEspecializacion.find(params[:id])
  end

  # POST /tipo_especializaciones
  # POST /tipo_especializaciones.json
  def create
    @tipo_especializacion = TipoEspecializacion.new(params[:tipo_especializacion])

    respond_to do |format|
      if @tipo_especializacion.save
        format.html { redirect_to @tipo_especializacion, notice: 'Tipo especializacion was successfully created.' }
        format.json { render json: @tipo_especializacion, status: :created, location: @tipo_especializacion }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_especializacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_especializaciones/1
  # PUT /tipo_especializaciones/1.json
  def update
    @tipo_especializacion = TipoEspecializacion.find(params[:id])

    respond_to do |format|
      if @tipo_especializacion.update_attributes(params[:tipo_especializacion])
        format.html { redirect_to @tipo_especializacion, notice: 'Tipo especializacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_especializacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_especializaciones/1
  # DELETE /tipo_especializaciones/1.json
  def destroy
    @tipo_especializacion = TipoEspecializacion.find(params[:id])
    @tipo_especializacion.destroy

    respond_to do |format|
      format.html { redirect_to tipo_especializaciones_url }
      format.json { head :no_content }
    end
  end
end
