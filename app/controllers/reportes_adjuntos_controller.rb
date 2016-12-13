class ReportesAdjuntosController < ApplicationController
  # GET /reportes_adjuntos
  # GET /reportes_adjuntos.json
  def index
    @reportes_adjuntos = ReporteAdjunto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportes_adjuntos }
    end
  end

  # GET /reportes_adjuntos/1
  # GET /reportes_adjuntos/1.json
  def show
    @reporte_adjunto = ReporteAdjunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reporte_adjunto }
    end
  end

  # GET /reportes_adjuntos/new
  # GET /reportes_adjuntos/new.json
  def new
    @reporte_adjunto = ReporteAdjunto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reporte_adjunto }
    end
  end

  # GET /reportes_adjuntos/1/edit
  def edit
    @reporte_adjunto = ReporteAdjunto.find(params[:id])
  end

  # POST /reportes_adjuntos
  # POST /reportes_adjuntos.json
  def create
    @reporte_adjunto = ReporteAdjunto.new(params[:reporte_adjunto])

    respond_to do |format|
      if @reporte_adjunto.save
        format.html { redirect_to @reporte_adjunto, notice: 'Reporte adjunto was successfully created.' }
        format.json { render json: @reporte_adjunto, status: :created, location: @reporte_adjunto }
      else
        format.html { render action: "new" }
        format.json { render json: @reporte_adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reportes_adjuntos/1
  # PUT /reportes_adjuntos/1.json
  def update
    @reporte_adjunto = ReporteAdjunto.find(params[:id])

    respond_to do |format|
      if @reporte_adjunto.update_attributes(params[:reporte_adjunto])
        format.html { redirect_to @reporte_adjunto, notice: 'Reporte adjunto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reporte_adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reportes_adjuntos/1
  # DELETE /reportes_adjuntos/1.json
  def destroy
    @reporte_adjunto = ReporteAdjunto.find(params[:id])
    @reporte_adjunto.destroy

    respond_to do |format|
      format.html { redirect_to reportes_adjuntos_url }
      format.json { head :no_content }
    end
  end
end