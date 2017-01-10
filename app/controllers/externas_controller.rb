class ExternasController < ApplicationController
  # GET /externas
  # GET /externas.json

  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis


  def index
    @externas = Externa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @externas }
    end
  end

  # GET /externas/1
  # GET /externas/1.json
  def show
    @externa = Externa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @externa }
    end
  end

  # GET /externas/new
  # GET /externas/new.json
  def new
    @externa = Externa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @externa }
    end
  end

  # GET /externas/1/edit
  def edit
    @externa = Externa.find(params[:id])
  end

  # POST /externas
  # POST /externas.json
  def create
    @externa = Externa.new(params[:externa])

    respond_to do |format|
      if @externa.save
        format.html { redirect_to @externa, notice: 'Externa was successfully created.' }
        format.json { render json: @externa, status: :created, location: @externa }
      else
        format.html { render action: "new" }
        format.json { render json: @externa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /externas/1
  # PUT /externas/1.json
  def update
    @externa = Externa.find(params[:id])

    respond_to do |format|
      if @externa.update_attributes(params[:externa])
        format.html { redirect_to @externa, notice: 'Externa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @externa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /externas/1
  # DELETE /externas/1.json
  def destroy
    @externa = Externa.find(params[:id])
    @externa.destroy

    respond_to do |format|
      format.html { redirect_to externas_url }
      format.json { head :no_content }
    end
  end
end
