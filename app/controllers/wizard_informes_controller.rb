# encoding: UTF-8
class WizardInformesController < ApplicationController
  before_filter :filtro_logueado
  before_filter :filtro_logueado_admin

  def paso1
    @titulo = "(Selección de Cliente)"    
    @clientes = Organizacion.clientes.delete_if{|c| c.id.eql? Organizacion::CONTEXTO_PAIS_ID}
    session[:informe_id] = nil    
    @contexto_pais = Organizacion.find Organizacion::CONTEXTO_PAIS_ID # Ojo Buscar cuál es el id del contexto Pais. Sino existe crear 
  end

  def paso2_especial
    @contexto_pais = Organizacion.find Organizacion::CONTEXTO_PAIS_ID # Ojo Buscar cuál es el id del contexto Pais. Sino existe crear 
    @informe = Informe.find params[:id] if params[:id]

    @reportes = @contexto_pais.reportes.order('orden ASC').sin_informe
    @reportes = @informe.reportes.order('orden ASC') + @reportes if @informe
    
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
      @reportes_impresos = @informe.reportes.impresos.order('orden ASC')
      # @reportes_pendientes = @informe.reportes.pendientes #
      # @reportes_pendientes = @cliente.reportes.sin_informe.pendientes

    else
      @cliente = Organizacion.find params[:cliente_id]
  		@reportes_clientes = @cliente.reportes.sin_informe.clientes.order('orden ASC')
  		@reportes_competencias = @cliente.reportes.sin_informe.competencias.order('orden ASC')
  		@reportes_actividades = @cliente.reportes.sin_informe.actividad.order('orden ASC')
      @reportes_impresos = @cliente.reportes.sin_informe.impresos.order('orden ASC')

    end
    @reportes_pendientes = @cliente.reportes.pendientes#_or_sin_informe

  end

  def agrupar
  	reportes_ids = params[:reportes_ids]
  	reportes_ids.each_pair do |key, valor|
  		reporte = Reporte.find key
  		reporte.seccion = valor
      reporte.informe_id = session[:informe_id] if session[:informe_id]
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
      @reportes_impresos = @informe.reportes.impresos.order('orden ASC')
      @reportes_pendientes = @informe.reportes.pendientes   
    else
      @cliente = Organizacion.find params[:cliente_id]      
  		@reportes_clientes = @cliente.reportes.sin_informe.clientes.order('orden ASC')
  		@reportes_competencias = @cliente.reportes.sin_informe.competencias.order('orden ASC')
      @reportes_actividades = @cliente.reportes.sin_informe.actividad.order('orden ASC')
  		@reportes_impresos = @cliente.reportes.sin_informe.impresos.order('orden ASC')
  		@reportes_pendientes = @cliente.reportes.sin_informe.pendientes
    end
  end

  def ordenar_especial
    if params[:informe_id]
      @informe = Informe.find params[:informe_id]
    else
      @informe = Informe.new()
      # @contexto_pais = Organizacion.find Organizacion::CONTEXTO_PAIS_ID 
      @informe.organizacion_id = Organizacion::CONTEXTO_PAIS_ID # Ojo Buscar cuál es el id del contexto Pais. Sino existe crear 
      @informe.fecha = DateTime.now
      @informe.autor = "Burson-Marsteller"
      @informe.titulo = "Titulares"
      
    flash[:success] = "Informme Guardado" if @informe.save 
    end
    total_reportes = 0
    reportes_ids = params[:reportes_ids]
    reportes_ids.each_pair do |key, valor|
      reporte = Reporte.find key
      reporte.orden = valor
      reporte.informe_id = @informe.id
      total_reportes += 1 if reporte.save
    end
    flash['alert-info'] = "Total de reportes organizados: #{total_reportes}."
    redirect_to action: 'paso2_especial', id: @informe.id
    
  end

  def ordenar
  	reportes_ids = params[:reportes_ids]
  	reportes_ids.each_pair do |key, valor|
  		reporte = Reporte.find key
  		reporte.orden = valor
      reporte.informe_id = session[:informe_id] if session[:informe_id]      
  		reporte.save
  	end
  	redirect_to :back
  end

  def paso4
    @contexto_pais = Organizacion.find Organizacion::CONTEXTO_PAIS_ID
    @informe_titulares = @contexto_pais.informes.creados_hoy.last
    @titulo = "(Datos del Informe)"
    session[:informe_id] = params[:informe_id] if params[:iid]
    if session[:informe_id]
      @informe = Informe.find session[:informe_id]
      @reportes_clientes = @informe.reportes.clientes.order('orden ASC')
      @reportes_competencias = @informe.reportes.competencias.order('orden ASC')
      @reportes_actividades = @informe.reportes.actividad.order('orden ASC')
      @reportes_impresos = @informe.reportes.impresos.order('orden ASC')
      @reportes_pendientes = @informe.reportes.pendientes
      @cliente = @informe.organizacion
    else
      @cliente = Organizacion.find params[:cliente_id] if params[:cliente_id] 
  		@informe = Informe.new
  		@informe.organizacion_id =  @cliente.id
      @reportes_clientes = @cliente.reportes.sin_informe.clientes.order('orden ASC')
      @reportes_competencias = @cliente.reportes.sin_informe.competencias.order('orden ASC')
      @reportes_actividades = @cliente.reportes.sin_informe.actividad.order('orden ASC')
      @reportes_impresos = @cliente.reportes.sin_informe.impresos.order('orden ASC')
      @reportes_pendientes = @cliente.reportes.sin_informe.pendientes      
  	end
  	@informe.autor = "Burson-Marsteller"
  end

  def paso4_crear
    params[:informe][:informe_especial_id] = nil if params[:informe][:informe_especial_id].eql? 'no'
    @informe = Informe.new(params[:informe])
    @cliente = Organizacion.find params[:cliente_id]
  	if @informe.save
  		flash[:success] = "Datos del informe guardados con éxito. "
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

  def paso4_actualizar
    params[:informe][:informe_especial_id] = nil if params[:informe][:informe_especial_id].eql? 'no'
    @informe = Informe.find(session[:informe_id])
    if @informe.update_attributes(params[:informe])
      flash[:success] = "Datos del informe guardados con éxito."
      redirect_to :back
    else
      flash[:danger] = "Error al intentar guardar los datos del informe. Por favor, revise los datos e inténtelo nuevamente: #{@informe.errors.full_messages.join(',')}"
      redirect_to action: 'paso4', id: @informe.id    
    end

  end


  def descargar
	@informe = Informe.find (params[:id])
  	
  	pdf = Pdf.generar(params[:id])
	send_data pdf.render,:filename => "informe_#{@informe.fecha}_#{@informe.organizacion.razon_social}.pdf",:type => "application/pdf", :disposition => "attachment"

  end

  def vista
	@informe = Informe.find (params[:id])

  @reportes_cliente = @informe.reportes.clientes.order('orden ASC')
  @reportes_competencias = @informe.reportes.competencias.order('orden ASC')
  @reportes_actividad = @informe.reportes.actividad.order('orden ASC')
  @reportes_impresos = @informe.reportes.impresos.order('orden ASC')


  @informe_especial = @informe.informe_especial
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