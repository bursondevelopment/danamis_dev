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
    @titulo = "(Preselección de Notas)"
    @cliente = Organizacion.find params[:id]
    @cliente.usuario_id = session[:usuario].id
    @cliente.save

    # Razon social
    @total_notas = Adjunto.creadas_hoy.buscar_clave_general @cliente.razon_social

    @notas_cliente_razon_social = Adjunto.creadas_hoy.buscar_clave_general @cliente.razon_social

    #representante
    representantes = @cliente.actores
    
    @notas_cliente_representante = Adjunto.where("1 = 0")
    @notas_cliente_cargo = Adjunto.where("1 = 0")
    
    if representantes.count > 0
      representantes.each do |representante|
        @total_notas += Adjunto.creadas_hoy.buscar_clave_general(representante.nombres)
        @notas_cliente_representante += Adjunto.creadas_hoy.buscar_clave_general(representante.nombres)

        @total_notas += Adjunto.creadas_hoy.buscar_clave_general(representante.cargo)
        @notas_cliente_cargo += Adjunto.creadas_hoy.buscar_clave_general(representante.cargo)
      end
    end

    # Medios y Productos
    marcas = @cliente.marcas

    @notas_cliente_marcas = Adjunto.where("1 = 0")
    @notas_cliente_productos = Adjunto.where("1 = 0")
    if marcas.count > 0

      marcas.each do |marca|
        @total_notas += Adjunto.creadas_hoy.buscar_clave_general(marca.nombre)
        @notas_cliente_marcas += Adjunto.creadas_hoy.buscar_clave_general(marca.nombre)
        productos = marca.productos
        productos.each do |producto|
          @total_notas += Adjunto.creadas_hoy.buscar_clave_general(producto.nombre)
          @notas_cliente_productos += Adjunto.creadas_hoy.buscar_clave_general(producto.nombre)
        end
      end
    end

    @total_notas_cliente = @notas_cliente_razon_social.count + @notas_cliente_representante.count + @notas_cliente_cargo.count + @notas_cliente_marcas.count + @notas_cliente_productos.count

    # Entorno
    @total_notas += Adjunto.creadas_hoy.buscar_clave_general(@cliente.entorno.nombre)
    @notas_entorno = Adjunto.creadas_hoy.buscar_clave_general(@cliente.entorno.nombre)

    #Competencia

    competencias = @cliente.competencia

    @notas_competencias = Adjunto.where("1 = 0")
    if competencias.count > 0
      competencias.each do |competencia|
        @total_notas += Adjunto.creadas_hoy.buscar_clave_general(competencia.razon_social)
        @notas_competencias += Adjunto.creadas_hoy.buscar_clave_general(competencia.razon_social)
      end
    end

    # Claves de Entorno
    palabras_claves = @cliente.entorno.claves
    palabras_claves_incluyentes = palabras_claves.incluyentes

    @notas_entorno_claves = Adjunto.where("1 = 0")
    if palabras_claves_incluyentes.count > 0
      palabras_claves_incluyentes.each do |clave|
        @total_notas += Adjunto.creadas_hoy.buscar_clave_general(clave.valor)
        @notas_entorno_claves += Adjunto.creadas_hoy.buscar_clave_general(clave.valor)
      end
    end

    palabras_claves_excluyentes = palabras_claves.excluyentes

    if palabras_claves_excluyentes.count > 0
      palabras_claves_excluyentes.each do |clave|
        @total_notas -= Adjunto.creadas_hoy.buscar_clave_general(clave.valor)
        @notas_entorno_claves -= Adjunto.creadas_hoy.buscar_clave_general(clave.valor)
      end
    end

    @total_notas_entorno = @notas_entorno.count + @notas_entorno_claves.count

    @total_notas = @total_notas.uniq

  end

end
