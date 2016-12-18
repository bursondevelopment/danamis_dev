# encoding: UTF-8
class AdjuntosController < ApplicationController
  # GET /adjuntos
  # GET /adjuntos.json
  def eliminar_total_adjuntos
    if params[:id]
      total_inicial = Adjunto.all.count
      sql = "DELETE FROM adjuntos WHERE medio_id = #{params[:id]} "
      ActiveRecord::Base.connection.execute(sql)
    else
      total_inicial = Adjunto.all.count
      sql = "TRUNCATE TABLE adjuntos"
      ActiveRecord::Base.connection.execute(sql)
    end

    redirect_to :back, notice: "#{total_inicial} Nota(s) adjunta(s) eliminadas del sistema"
  end

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
    @adjunto.medio_id = @medio_id = params[:medio_id] if params[:medio_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adjunto }
    end
  end

  # GET /adjuntos/1/edit
  def edit
    @adjunto = Adjunto.find(params[:id])
    @medio_id = params[:medio_id] if params[:medio_id]    
  end

  # POST /adjuntos
  # POST /adjuntos.json
  def create
    @adjunto = Adjunto.new(params[:adjunto])

    respond_to do |format|
      if @adjunto.save
        if params[:medio_id]
          format.html { redirect_to medio_path(params[:medio_id]), notice: 'Nota Adjunta cargada con éxito.' }
        else
          format.html { redirect_to @adjunto, notice: 'Nota Adjunta cargada con éxito.' }
          format.json { render json: @adjunto, status: :created, location: @adjunto }
        end
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
        if params[:medio_id]
          format.html { redirect_to medio_path(params[:medio_id]), notice: 'Nota Adjunta actualizada con éxito.' }
        else
          format.html { redirect_to @adjunto, notice: 'Nota Adjunta actualizada con éxito.' }
          format.json { render json: @adjunto, status: :created, location: @adjunto }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: 
          @adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adjuntos/1
  # DELETE /adjuntos/1.json
  def destroy
    @adjunto = Adjunto.find(params[:id])
    @adjunto.destroy

    respond_to do |format|
        redirect_path = params[:medio_id] ? medio_path(params[:medio_id]) : adjuntos_url 
        format.html { redirect_to redirect_path, notice: 'Nota Adjunta Eliminada.' }
      format.json { head :no_content }
    end
  end
end
