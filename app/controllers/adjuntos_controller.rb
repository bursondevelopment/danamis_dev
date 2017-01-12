# encoding: UTF-8
class AdjuntosController < ApplicationController
  before_filter :filtro_logueado
  before_filter :filtro_logueado_dunamis
  # GET /adjuntos
  # GET /adjuntos.json

  def descargar
    #ids = params[:id]
    #reportes = Reportes.where(:id => ids.split(","))
    file_name = Pdf.descargar_reportes_excel
    send_file file_name, :type => "application/vnd.ms-excel", :filename => "reportes.xls", :stream => false

    File.delete(file_name)
  end

  def full_index
    @reportes = Reporte.order('created_at DESC')
  end

  def descartar_adjunto
    nota = Adjunto.find params[:id]
    nota.valida = false
    nota.save

    if session[:cliente_id]
      ao = AdjuntoOrganizacion.where(organizacion_id: session[:cliente_id], adjunto_id: params[:id]).first
      ao.destroy
    end

    redirect_to :back    
  end

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
    @adjuntos = Adjunto.order('created_at DESC')

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


  def crear_propio
      data = params[:adjunto][:url]
      @adjunto = Adjunto.new(params[:adjunto])
      @adjunto.url = data.original_filename
      if @adjunto.save
        flash[:success] = "Agregado Adjunto"
        begin
          ext = data.original_filename.split('.').last
        
          nombre = "adjunto_#{@adjunto.id}_medio_#{@adjunto.medio_id}.#{ext}"
          archivo = "#{Rails.root}/app/assets/images/adjuntos/#{nombre}"

          data = data.tempfile
          File.open("#{archivo}", "wb") {|file| file.write data.read}

          @adjunto.url = archivo
          if @adjunto.save
            flash[:success] = "Agregado Adjunto. Archivo guardado"

            if params[:cliente_id]
              @cliente = Organizacion.find params[:cliente_id]
              ao = AdjuntoOrganizacion.new
              ao.organizacion_id = @cliente.id
              ao.adjunto_id = @adjunto.id
              if ao.save
                flash[:success] = "Agregado Adjunto. Archivo guardado. Asociado al cliente "
              else
                flash[:alert] = "Error al intentar asociar adjunto con el cliente: #{ao.errors.full_messages.join(". ")}"
              end
            end
          else
            flash[:alert] = "Error al intentar guardar los adjuntos: #{@adjunto.errors.full_messages.join(". ")}"
          end
        rescue Exception => e
          flash[:alert] = "Error al intentar adjuntar el archivo: #{e.message}"
        end
      else
        flash[:alert] = "Error al intentar guardar el Adjunto: #{@adjunto.errors.full_messages.join(". ")}"
      end
      redirect_to :back
  end
    

  def create
    @adjunto = Adjunto.new(params[:adjunto])

    respond_to do |format|
      if @adjunto.save
        if params[:medio_id]
          format.html { redirect_to medio_path(params[:medio_id]), notice: 'Nota Adjunta cargada con éxito.' }
        elsif params[:url_return]
          if session[:cliente_id]
            @cliente = Organizacion.find session[:cliente_id]
            ao = AdjuntoOrganizacion.new
            ao.organizacion_id = @cliente.id
            ao.adjunto_id = @adjunto.id
          end
          if ao.save
            format.html { redirect_to params[:url_return], notice: 'Nota adjunta cargada con éxito.' }
          else
            format.html { redirect_to params[:url_return], notice: 'Error al asociar el adjunto con el cliente. Sin embargo, el adjunto fue agregada. Vaya al paso 2 de este Wizard y seleccione el adjunto correspondente.' }
            return
          end
        else
          format.html { redirect_to @adjunto, notice: 'Nota Adjunta cargada con éxito.' }
          format.json { render json: @adjunto, status: :created, location: @adjunto }
        end
      else
        if params[:url_return]
          redirect_to params[:url_return], notice: "Error al agregar el adjunto. revise los campos e inténtelo de nuevo. #{@adjunto.errors.full_messages.join('.')}"
          return
        else
          format.html { render action: "new" }
          format.json { render json: @adjunto.errors, status: :unprocessable_entity }
        end
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
    
    if @adjunto.impreso?
      @impreso = true
      archivo = @adjunto.url
      begin
        File.delete(archivo)
        @adjunto.destroy
      rescue Exception => e
        flash[:alert] = "Error al intentar eliminar. #{e.message}"
      end

    end

    respond_to do |format|
      if @impreso
        format.html { redirect_to :back, notice: 'Nota Adjunta Eliminada.' }
      else
        redirect_path = params[:medio_id] ? medio_path(params[:medio_id]) : adjuntos_path 
        format.html { redirect_to redirect_path, notice: 'Nota Adjunta Eliminada.' }
        format.json { head :no_content }
      end
    end
  end

end
