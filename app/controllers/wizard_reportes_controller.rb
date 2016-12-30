# encoding: UTF-8
class WizardReportesController < ApplicationController
  before_filter :filtro_logueado

  # Pasos iniciales para el wizard

  # Debe estar corriendo el barrido en background o al momento justo de hacerse el monitoreo debe hacerse el barrido general

  # mensaje: "Se procederá a hacer un barrido previo para obtener resultados de notas más recientes, por favor espere"

  def paso1
    @titulo = "(Selección de Clientes)"    
    @clientes_libres = Organizacion.clientes.where(:usuario_id => nil).order('razon_social ASC')
    @mis_clientes = Organizacion.clientes.where(:usuario_id => session[:usuario].id).order('razon_social ASC')
    
  end

  def paso1_liberar
    @cliente = Organizacion.find params[:id]
    @cliente.usuario_id = nil
    @cliente.save

    redirect_to :back
    
  end

  def paso2
    @cliente = Organizacion.find params[:id]
    @titulo = "(Preselección de Notas) - #{@cliente.razon_social}"
    session[:cliente_id] = @cliente.id 
    @cliente.usuario_id = session[:usuario].id
    @cliente.save

    # Razon social
    notas = Adjunto.creadas_hoy
    # notas = Adjunto.creadas_antes_de_hoy#creadas_hoy
    @total_notas = notas.buscar_clave_general @cliente.razon_social

    @notas_cliente_razon_social = notas.buscar_clave_general @cliente.razon_social

    #representante
    representantes = @cliente.actores
    
    @notas_cliente_representante = Adjunto.where("1 = 0")
    @notas_cliente_cargo = Adjunto.where("1 = 0")
    
    if representantes.count > 0
      representantes.each do |representante|
        @total_notas += notas.buscar_clave_general(representante.nombres)
        @notas_cliente_representante += notas.buscar_clave_general(representante.nombres)

        @total_notas += notas.buscar_clave_general(representante.cargo)
        @notas_cliente_cargo += notas.buscar_clave_general(representante.cargo)
      end
    end

    # Medios y Productos
    marcas = @cliente.marcas

    @notas_cliente_marcas = Adjunto.where("1 = 0")
    @notas_cliente_productos = Adjunto.where("1 = 0")
    if marcas.count > 0

      marcas.each do |marca|
        @total_notas += notas.buscar_clave_general(marca.nombre)
        @notas_cliente_marcas += notas.buscar_clave_general(marca.nombre)
        productos = marca.productos
        productos.each do |producto|
          @total_notas += notas.buscar_clave_general(producto.nombre)
          @notas_cliente_productos += notas.buscar_clave_general(producto.nombre)
        end
      end
    end

    @total_notas_cliente = @notas_cliente_razon_social.count + @notas_cliente_representante.count + @notas_cliente_cargo.count + @notas_cliente_marcas.count + @notas_cliente_productos.count

    # Entorno
    @total_notas += notas.buscar_clave_general(@cliente.entorno.nombre)
    @notas_entorno = notas.buscar_clave_general(@cliente.entorno.nombre)

    #Competencia

    competencias = @cliente.competencia

    @notas_competencias = Adjunto.where("1 = 0")
    if competencias.count > 0
      competencias.each do |competencia|
        @total_notas += notas.buscar_clave_general(competencia.razon_social)
        @notas_competencias += notas.buscar_clave_general(competencia.razon_social)
      end
    end

    # Claves de Entorno
    palabras_claves = @cliente.entorno.claves
    palabras_claves_incluyentes = palabras_claves.incluyentes

    @notas_entorno_claves = Adjunto.where("1 = 0")
    if palabras_claves_incluyentes.count > 0
      palabras_claves_incluyentes.each do |clave|
        @total_notas += notas.buscar_clave_general(clave.valor)
        @notas_entorno_claves += notas.buscar_clave_general(clave.valor)
      end
    end

    palabras_claves_excluyentes = palabras_claves.excluyentes

    if palabras_claves_excluyentes.count > 0
      palabras_claves_excluyentes.each do |clave|
        @total_notas -= notas.buscar_clave_general(clave.valor)
        @notas_entorno_claves -= notas.buscar_clave_general(clave.valor)
      end
    end

    @total_notas_entorno = @notas_entorno.count + @notas_entorno_claves.count

    @total_notas = @total_notas.uniq

  end

  def paso2_guardar
    adjuntos_validos = params[:notas]

    adjuntos = Adjunto.creadas_antes_de_hoy #.creadas_hoy
    if adjuntos_validos
      cliente = Organizacion.find session[:cliente_id]
      total_cargadas = 0
      total_errores = ""
      adjuntos_validos.each_pair do |adjunto_id, val|
        begin
          ao = AdjuntoOrganizacion.new
          ao.adjunto_id = adjunto_id
          ao.organizacion_id = cliente.id
          total_cargadas+=1 if ao.save
        rescue Exception => e
          total_errores += "#{e} | "
        end
      end

    end

    flash[:success] = "Total Adjuntos nuevos asociados al cliente: #{total_cargadas}." 

    redirect_to :action => 'paso3'
    
  end

  def paso3
    @cliente = Organizacion.find session[:cliente_id]
    @titulo = "(Datos del Reporte) - #{@cliente.razon_social}"
    @actores = Actor.order('nombres ASC')
    @reporte = params[:id] ? Reporte.find(params[:id]) : Reporte.new  
    @reporte.organizacion_id = @cliente.id
    @reportes = Reporte.del_cliente @cliente.id

    #@table_name = 'validas'
    cargar_lista_notas

  end

  def paso3_guardar
    if params[:id]
      repo_aux = params[:reporte]
      @reporte = Reporte.find params[:id]
      @reporte.actor_id = repo_aux[:actor_id]
      @reporte.titulo = repo_aux[:titulo]
      @reporte.argumento = repo_aux[:argumento]
    else
      @reporte = Reporte.new(params[:reporte])
    end
    if @reporte.save
      flash[:success] = "Datos elementales del reporte guardados con éxito."
      redirect_to action: "paso4/#{@reporte.id}" 
    else
      flash[:alert] = "Error al intentar guardar los datos del reporte: #{@reporte.errors.full_messages.join(' ')}"
      redirect_to :back
    end
  end

  def paso4

    @reporte = Reporte.find params[:id]

    @cliente = Organizacion.find session[:cliente_id]
    @titulo = "(Agregar notas adjuntas) - #{@cliente.razon_social}"

    cargar_lista_notas

  end


  def destroy_reporte
    @reporte = Reporte.find(params[:id])
    @reporte.destroy

    respond_to do |format|
      format.html { redirect_to action: 'paso3', notice: 'Reporte Eliminado con éxito' }
      format.json { head :no_content }
    end
  end

  private

  def cargar_lista_notas

      #notas = Adjunto.del_cliente_antes_hoy(session[:cliente_id]).creadas_hoy

      @cliente = Organizacion.find session[:cliente_id]        
      reportes =  @cliente.reportes.creados_hoy

      hay_adjuntos = false

      reportes.each do |reporte|
        hay_adjuntos = true if reporte.adjuntos.count > 0
      end

      if reportes.count > 0 and hay_adjuntos
        # notas = Adjunto.del_cliente_sin_reporte(session[:cliente_id]).del_cliente_antes_hoy(session[:cliente_id])
        notas = Adjunto.del_cliente_hoy(session[:cliente_id]).del_cliente_sin_reporte(session[:cliente_id])
        notas = Adjunto.del_cliente_antes_hoy(session[:cliente_id]).del_cliente_sin_reporte(session[:cliente_id])

      else
        notas = Adjunto.del_cliente_hoy(session[:cliente_id])
        notas = Adjunto.del_cliente_antes_hoy(session[:cliente_id])        
      end

      #notas = @cliente.adjuntos.sin_reportes

      @total_notas = @cliente.adjuntos

      # Razon social
      #@total_notas = notas.buscar_clave_general @cliente.razon_social

      @notas_cliente_razon_social = notas.buscar_clave_general @cliente.razon_social

      #representante
      representantes = @cliente.actores
      
      @notas_cliente_representante = Adjunto.where("1 = 0")
      @notas_cliente_cargo = Adjunto.where("1 = 0")
      
      if representantes.count > 0
        representantes.each do |representante|
          #@total_notas += notas.buscar_clave_general(representante.nombres)
          @notas_cliente_representante += notas.buscar_clave_general(representante.nombres)

          #@total_notas += notas.buscar_clave_general(representante.cargo)
          @notas_cliente_cargo += notas.buscar_clave_general(representante.cargo)
        end
      end

      # Medios y Productos
      marcas = @cliente.marcas

      @notas_cliente_marcas = Adjunto.where("1 = 0")
      @notas_cliente_productos = Adjunto.where("1 = 0")
      if marcas.count > 0

        marcas.each do |marca|
          @total_notas += notas.buscar_clave_general(marca.nombre)
          @notas_cliente_marcas += notas.buscar_clave_general(marca.nombre)
          productos = marca.productos
          productos.each do |producto|
            #@total_notas += notas.buscar_clave_general(producto.nombre)
            @notas_cliente_productos += notas.buscar_clave_general(producto.nombre)
          end
        end
      end

      @total_notas_cliente = @notas_cliente_razon_social.count + @notas_cliente_representante.count + @notas_cliente_cargo.count + @notas_cliente_marcas.count + @notas_cliente_productos.count

      # Entorno
      #@total_notas += notas.buscar_clave_general(@cliente.entorno.nombre)
      @notas_entorno = notas.buscar_clave_general(@cliente.entorno.nombre)

      #Competencia

      competencias = @cliente.competencia

      @notas_competencias = Adjunto.where("1 = 0")
      if competencias.count > 0
        competencias.each do |competencia|
          #@total_notas += notas.buscar_clave_general(competencia.razon_social)
          @notas_competencias += notas.buscar_clave_general(competencia.razon_social)
        end
      end

      # Claves de Entorno
      palabras_claves = @cliente.entorno.claves
      palabras_claves_incluyentes = palabras_claves.incluyentes

      @notas_entorno_claves = Adjunto.where("1 = 0")
      if palabras_claves_incluyentes.count > 0
        palabras_claves_incluyentes.each do |clave|
          #@total_notas += notas.buscar_clave_general(clave.valor)
          @notas_entorno_claves += notas.buscar_clave_general(clave.valor)
        end
      end

      palabras_claves_excluyentes = palabras_claves.excluyentes

      if palabras_claves_excluyentes.count > 0
        palabras_claves_excluyentes.each do |clave|
          #@total_notas -= notas.buscar_clave_general(clave.valor)
          @notas_entorno_claves -= notas.buscar_clave_general(clave.valor)
        end
      end

      @total_notas_entorno = @notas_entorno.count + @notas_entorno_claves.count

      @total_notas = @total_notas.uniq
    
  end

end
