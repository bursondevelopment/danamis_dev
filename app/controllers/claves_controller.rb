class ClavesController < ApplicationController
  # GET /claves
  # GET /claves.json
  def index
    @claves = Clave.all

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
    @clave = Clave.new(params[:clave])

    respond_to do |format|
      if @clave.save
        format.html { redirect_to @clave, notice: 'Clave was successfully created.' }
        format.json { render json: @clave, status: :created, location: @clave }
      else
        format.html { render action: "new" }
        format.json { render json: @clave.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /claves/1
  # PUT /claves/1.json
  def update
    @clave = Clave.find(params[:id])

    respond_to do |format|
      if @clave.update_attributes(params[:clave])
        format.html { redirect_to @clave, notice: 'Clave was successfully updated.' }
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
    @clave.destroy

    respond_to do |format|
      format.html { redirect_to claves_url }
      format.json { head :no_content }
    end
  end
end
