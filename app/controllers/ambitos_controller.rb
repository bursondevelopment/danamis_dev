class AmbitosController < ApplicationController
  # GET /ambitos
  # GET /ambitos.json

  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis

  def index
    @ambitos = Ambito.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ambitos }
    end
  end

  # GET /ambitos/1
  # GET /ambitos/1.json
  def show
    @ambito = Ambito.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ambito }
    end
  end

  # GET /ambitos/new
  # GET /ambitos/new.json
  def new
    @ambito = Ambito.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ambito }
    end
  end

  # GET /ambitos/1/edit
  def edit
    @ambito = Ambito.find(params[:id])
  end

  # POST /ambitos
  # POST /ambitos.json
  def create
    @ambito = Ambito.new(params[:ambito])

    respond_to do |format|
      if @ambito.save
        format.html { redirect_to @ambito, notice: 'Ambito was successfully created.' }
        format.json { render json: @ambito, status: :created, location: @ambito }
      else
        format.html { render action: "new" }
        format.json { render json: @ambito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ambitos/1
  # PUT /ambitos/1.json
  def update
    @ambito = Ambito.find(params[:id])

    respond_to do |format|
      if @ambito.update_attributes(params[:ambito])
        format.html { redirect_to @ambito, notice: 'Ambito was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ambito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ambitos/1
  # DELETE /ambitos/1.json
  def destroy
    @ambito = Ambito.find(params[:id])
    @ambito.destroy

    respond_to do |format|
      format.html { redirect_to ambitos_url }
      format.json { head :no_content }
    end
  end
end
