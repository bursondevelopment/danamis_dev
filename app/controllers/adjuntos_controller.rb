class AdjuntosController < ApplicationController
  # GET /adjuntos
  # GET /adjuntos.json
  def index
    @adjuntos = Adjunto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adjuntos }
    end
  end

  # GET /adjuntos/1
  # GET /adjuntos/1.json
  def show
    @adjunto = Adjunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adjunto }
    end
  end

  # GET /adjuntos/new
  # GET /adjuntos/new.json
  def new
    @adjunto = Adjunto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adjunto }
    end
  end

  # GET /adjuntos/1/edit
  def edit
    @adjunto = Adjunto.find(params[:id])
  end

  # POST /adjuntos
  # POST /adjuntos.json
  def create
    @adjunto = Adjunto.new(params[:adjunto])

    respond_to do |format|
      if @adjunto.save
        format.html { redirect_to @adjunto, notice: 'Adjunto was successfully created.' }
        format.json { render json: @adjunto, status: :created, location: @adjunto }
      else
        format.html { render action: "new" }
        format.json { render json: @adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adjuntos/1
  # PUT /adjuntos/1.json
  def update
    @adjunto = Adjunto.find(params[:id])

    respond_to do |format|
      if @adjunto.update_attributes(params[:adjunto])
        format.html { redirect_to @adjunto, notice: 'Adjunto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adjuntos/1
  # DELETE /adjuntos/1.json
  def destroy
    @adjunto = Adjunto.find(params[:id])
    @adjunto.destroy

    respond_to do |format|
      format.html { redirect_to adjuntos_url }
      format.json { head :no_content }
    end
  end
end
