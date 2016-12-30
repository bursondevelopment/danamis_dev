# encoding: UTF-8
module ReportesHelper

  def list_to_adjuntos reporte
	links = ""
	reporte.adjuntos.each_with_index do |ad, i|
    	links += link_to_adjunto ad
    	links += " - " if i < (reporte.adjuntos.count - 1)
    end
    raw links
  end

  def list_to_adjuntos_desagregables reporte
	links = ""
	reporte.adjuntos.each_with_index do |ad, i|
    	links += link_to_adjunto ad
    	links += btn_desagregar_adjunto reporte.id, ad.id
    	links += " - " if i < (reporte.adjuntos.count - 1)
    end
    links
  end


  def contenedor_media_descripcion reporte
    contenedor = "<div class='media'>"
    contenedor += "<div class='media-body'>"
    contenedor += "<h4>"
    contenedor += "#{reporte.actor.nombres_cargo}: "
    contenedor += reporte.titulo
    contenedor += btn_mini 'Editar este reporte', "/wizard_reportes/paso3/#{reporte.id}", 'btn-info', 'icon-edit'
    contenedor += btn_mini_del 'Eliminar este reporte', "/wizard_reportes/destroy_reporte/#{reporte.id}", 'btn-danger', 'icon-trash', 'Este acción eliminará el reporte del sistema. ¿Está totalmente seguro?'
    contenedor += "</h4>"
    contenedor += "<p>"
    contenedor += "#{reporte.argumento} "
    contenedor += list_to_adjuntos_desagregables reporte
    contenedor += "</p>"
    contenedor += "</div>"
    contenedor += "</div>"
    contenedor
  end


  def contenedor_media_descripcion_sin_editar reporte
    contenedor = "<div class='media'>"
    contenedor += "<div class='media-body'>"
    contenedor += "<h4>"
    contenedor += "#{reporte.actor.nombres_cargo}: "
    contenedor += reporte.titulo
    contenedor += "</h4>"
    contenedor += "<p>"
    contenedor += "#{reporte.argumento} "
    contenedor += list_to_adjuntos reporte
    contenedor += "</p>"
    contenedor += "</div>"
    contenedor += "</div>"
    contenedor
  end

end
