# encoding: UTF-8
class WizardInformesController < ApplicationController
  before_filter :filtro_logueado

  def paso1
    @titulo = "(Selección de Cliente)"    
    @clientes = Organizacion.clientes
    session[:informe_id] = nil    
  end

  def paso2
    @titulo = "(Agrupacion por Sección)"
    session[:informe_id] = params[:id] if params[:id] 

    if session[:informe_id]
      @informe = Informe.find session[:informe_id]
      @cliente = @informe.organizacion

      @reportes_clientes = @informe.reportes.clientes.order('orden ASC')
      @reportes_competencias = @informe.reportes.competencias.order('orden ASC')
      @reportes_actividades = @informe.reportes.actividad.order('orden ASC')
      @reportes_pendientes = @informe.reportes.pendientes   

    else
      @cliente = Organizacion.find params[:cliente_id]

  		@reportes_clientes = @cliente.reportes.sin_informe.clientes.order('orden ASC')
  		@reportes_competencias = @cliente.reportes.sin_informe.competencias.order('orden ASC')
  		@reportes_actividades = @cliente.reportes.sin_informe.actividad.order('orden ASC')
  		@reportes_pendientes = @cliente.reportes.sin_informe.pendientes
	end

  end

  def agrupar
  	reportes_ids = params[:reportes_ids]
  	reportes_ids.each_pair do |key, valor|
  		reporte = Reporte.find key
  		reporte.seccion = valor
  		reporte.save
  	end
  	redirect_to :back
  end

  def paso3
  	@titulo = "(Ordenar por Sección)"
    session[:informe_id] = params[:id] if params[:id] 

    if session[:informe_id]
      @informe = Informe.find session[:informe_id]
      @cliente = @informe.organizacion

      @reportes_clientes = @informe.reportes.clientes.order('orden ASC')
      @reportes_competencias = @informe.reportes.competencias.order('orden ASC')
      @reportes_actividades = @informe.reportes.actividad.order('orden ASC')
      @reportes_pendientes = @informe.reportes.pendientes   
    else
      @cliente = Organizacion.find params[:cliente_id]      
  		@reportes_clientes = @cliente.reportes.sin_informe.clientes.order('orden ASC')
  		@reportes_competencias = @cliente.reportes.sin_informe.competencias.order('orden ASC')
  		@reportes_actividades = @cliente.reportes.sin_informe.actividad.order('orden ASC')
  		@reportes_pendientes = @cliente.reportes.sin_informe.pendientes
    end
  end

  def ordenar
  	reportes_ids = params[:reportes_ids]
  	reportes_ids.each_pair do |key, valor|
  		reporte = Reporte.find key
  		reporte.orden = valor
  		reporte.save
  	end
  	redirect_to :back
  end

  def paso4
    @titulo = "(Datos del Informe)"
    session[:informe_id] = params[:informe_id] if params[:iid]
    if session[:informe_id]
      @informe = Informe.find session[:informe_id]
      @reportes_clientes = @informe.reportes.clientes.order('orden ASC')
      @reportes_competencias = @informe.reportes.competencias.order('orden ASC')
      @reportes_actividades = @informe.reportes.actividad.order('orden ASC')
      @reportes_pendientes = @informe.reportes.pendientes
      @cliente = @informe.organizacion
    else
      @cliente = Organizacion.find params[:cliente_id] if params[:cliente_id] 
  		@informe = Informe.new
  		@informe.organizacion_id =  @cliente.id
      @reportes_clientes = @cliente.reportes.sin_informe.clientes.order('orden ASC')
      @reportes_competencias = @cliente.reportes.sin_informe.competencias.order('orden ASC')
      @reportes_actividades = @cliente.reportes.sin_informe.actividad.order('orden ASC')
      @reportes_pendientes = @cliente.reportes.sin_informe.pendientes      
  	end
  	@informe.autor = "Burson-Marsteller"
  end

  def paso4_guardar
	@informe = Informe.new(params[:informe])
	@cliente = Organizacion.find params[:cliente_id]
  	if @informe.save
  		flash[:success] = "Datos del informe guardados con éxito"
  		@reportes = @cliente.reportes.sin_informe
  		total_cargados = 0
  		total_errores = 0
  		session[:informe_id] = @informe.id
  		@reportes.each do |reporte|
  			reporte.informe_id = @informe.id
  			if reporte.save
  				total_cargados += 1
  			else
          total_errores += 1
        end
      end
  		flash[:danger] = "Error al intentar la carga de los reportes (#{total_errores})" if total_errores > 0
      flash[:success] += "#{total_cargados} Reportes cargados."

      redirect_to :back
    else
      flash[:danger] = "Error al intentar guardar los datos del informe. Por favor, revise los datos e inténtelo nuevamente: #{@informe.errors.full_messages.join(',')}"
      redirect_to action: 'paso4', id: @infomre.id    
    end

  end

  def descargar
	@informe = Informe.find (params[:id])
  	
  	pdf = Pdf.generar(params[:id])
	send_data pdf.render,:filename => "informe_#{@informe.fecha}_#{@informe.organizacion.razon_social}.pdf",:type => "application/pdf", :disposition => "attachment"

  end

  def vista
	@informe = Informe.find (params[:id])
  	
  end

  def seleccionar_destinos
    @informe = Informe.find (params[:id])  
  end

  def enviar_por_correo
    @informe = Informe.find (params[:id])
    begin
      InformeMailer.enviar_informe(params[:id], params[:correos]).deliver
      flash[:success] = 'Correo Enviado Satisfactoriamente'
    rescue Exception => ex
      puts "Error al intenter enviar: #{ex}"
      flash[:success] = "Error al intenter enviar: #{ex}"
    end

    if params[:url]
      redirect_to informes_path
    else
      redirect_to action: "paso4/#{@informe.organizacion_id}"
    end
  end

end