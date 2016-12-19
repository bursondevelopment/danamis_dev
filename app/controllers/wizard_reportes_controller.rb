# encoding: UTF-8
class WizardReportesController < ApplicationController
  before_filter :filtro_logueado

  # Pasos iniciales para el wizard

  # Debe estar corriendo el barrido en background o al momento justo de hacerse el monitoreo debe hacerse el barrido general

  # mensaje: "Se procederá a hacer un barrido previo para obtener resultados de notas más recientes, por favor espere"

  def paso1
    @titulo = "Selección de Clientes"
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
    @cliente.usuario_id = session[:usuario].id
    @cliente.save

    # hacer un grupo que contenga todas las palabras claves
    # - Palabras claves del cliente: razon social

    @notas_cliente_razon = Adjunto.creadas_hoy.buscar_clave_general @cliente.razon_social

    # Lista de Cliente Medios

    # Gerarquizarlo

  end

end
