class InternasController < ApplicationController
  # GET /internas
  # GET /internas.json
  def index
    @internas = Interna.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @internas }
    end
  end

  # GET /internas/1
  # GET /internas/1.json
  def show
    @interna = Interna.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @interna }
    end
  end

  # GET /internas/new
  # GET /internas/new.json
  def new
    @interna = Interna.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interna }
    end
  end

  # GET /internas/1/edit
  def edit
    @interna = Interna.find(params[:id])
  end

  # POST /internas
  # POST /internas.json
  def create
    @interna = Interna.new(params[:interna])

    respond_to do |format|
      if @interna.save
        format.html { redirect_to @interna, notice: 'Interna was successfully created.' }
        format.json { render json: @interna, status: :created, location: @interna }
      else
        format.html { render action: "new" }
        format.json { render json: @interna.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /internas/1
  # PUT /internas/1.json
  def update
    @interna = Interna.find(params[:id])

    respond_to do |format|
      if @interna.update_attributes(params[:interna])
        format.html { redirect_to @interna, notice: 'Interna was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interna.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internas/1
  # DELETE /internas/1.json
  def destroy
    @interna = Interna.find(params[:id])
    @interna.destroy

    respond_to do |format|
      format.html { redirect_to internas_url }
      format.json { head :no_content }
    end
  end
end
