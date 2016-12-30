module ReportesAdjuntosHelper

  def btn_desagregar_adjunto reporte_id, adjunto_id
	" <b class='tooltip-btn' data_toggle='tooltip' title='Desagregar Adjunto al reporte'><a href='/reportes_adjuntos/#{reporte_id},#{adjunto_id}' class='btn btn-danger btn-mini' data-method='delete' rel='nofollow' remote='true'><i class='icon-arrow-down icon-white'></i></a></b>"
  end

  def btn_agregar_adjunto reporte_id, adjunto_id
	" <b class='tooltip-btn' data_toggle='tooltip' title='Agregar Adjunto al reporte'><a href='/reportes_adjuntos/agregar_adjunto/#{reporte_id},#{adjunto_id}' class='btn btn-success btn-mini'><i class='icon-arrow-up icon-white'></i></a></b>"
  end

end
