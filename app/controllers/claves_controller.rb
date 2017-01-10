# encoding: UTF-8
class ClavesController < ApplicationController
  # GET /claves
  # GET /claves.json

  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis

  def index
    @claves = Clave.order('created_at ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @claves }
    end
  end

  # GET /claves/1
  # GET /claves/1.json
  def show
    @clave = Clave.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clave }
    end
  end

  # GET /claves/new
  # GET /claves/new.json
  def new
    @clave = Clave.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clave }
    end
  end

  # GET /claves/1/edit
  def edit
    @clave = Clave.find(params[:id])
  end

  # POST /claves
  # POST /claves.json
  def create
    clave = params[:clave]
    palabras = clave[:valor].split(";")
    errores = ""
    total = 0
    palabras.each_with_index do |pa,i|
      clave[:valor] = pa
      begin
        obj = Clave.new(clave)
        obj.save
        total += 1
      rescue Exception => e
        errores = "error en la palabra #{i+1}:< #{e} > |"
      end

    end
    mensaje = "Total de palabras: #{total}. "
    @entorno = Entorno.find params[:clave][:entorno_id]        
    mensaje += "Errores: #{errores}" unless (errores.eql? '')
    redirect_to entorno_path(@entorno), notice: mensaje

  end

  # PUT /claves/1
  # PUT /claves/1.json
  def update
    @clave = Clave.find(params[:id])

    respond_to do |format|
      if @clave.update_attributes(params[:clave])
        format.html { redirect_to @clave, notice: 'Palabra clave actualizada con éxito.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clave.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claves/1
  # DELETE /claves/1.json
  def destroy
    @clave = Clave.find(params[:id])
    @entorno = @clave.entorno
    @clave.destroy

    respond_to do |format|
      format.html { redirect_to entorno_path(@entorno), notice: 'Palabra eliminada' }
      format.json { head :no_content }
    end
  end
end
