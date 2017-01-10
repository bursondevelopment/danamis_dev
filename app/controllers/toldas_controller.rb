class ToldasController < ApplicationController
  # GET /toldas
  # GET /toldas.json
  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis


  def index
    @toldas = Tolda.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @toldas }
    end
  end

  # GET /toldas/1
  # GET /toldas/1.json
  def show
    @tolda = Tolda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tolda }
    end
  end

  # GET /toldas/new
  # GET /toldas/new.json
  def new
    @tolda = Tolda.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tolda }
    end
  end

  # GET /toldas/1/edit
  def edit
    @tolda = Tolda.find(params[:id])
  end

  # POST /toldas
  # POST /toldas.json
  def create
    @tolda = Tolda.new(params[:tolda])

    respond_to do |format|
      if @tolda.save
        format.html { redirect_to @tolda, notice: 'Tolda was successfully created.' }
        format.json { render json: @tolda, status: :created, location: @tolda }
      else
        format.html { render action: "new" }
        format.json { render json: @tolda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /toldas/1
  # PUT /toldas/1.json
  def update
    @tolda = Tolda.find(params[:id])

    respond_to do |format|
      if @tolda.update_attributes(params[:tolda])
        format.html { redirect_to @tolda, notice: 'Tolda was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tolda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /toldas/1
  # DELETE /toldas/1.json
  def destroy
    @tolda = Tolda.find(params[:id])
    @tolda.destroy

    respond_to do |format|
      format.html { redirect_to toldas_url }
      format.json { head :no_content }
    end
  end
end
