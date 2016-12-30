module AdjuntosHelper

  def link_to_adjunto adjunto
    link_to adjunto.medio.descripcion, adjunto.url, {:target => '_blank'}
  end

  def btn_to_adjunto adjunto
    link_to adjunto.medio.descripcion, adjunto.url, {:class => 'btn btn-link', :target => '_blank'}
  end

  def btn_to_adjunto_icon_mini adjunto

  	btn = "<b class='tooltip-btn' data_toggle='tooltip' title='Ver enlace foraneo'>"
    btn += "link_to #{adjunto.url}, { :role => 'button', :class => 'btn btn-success btn-mini'} do"
    btn += "content_tag(:i, "", class: 'icon-share icon-white')"
    btn += "end"
    btn += "</b>"

    raw btn
  end

  def btn_to_descartar_adjunto adjunto_id
    " <b class='tooltip-btn' data_toggle='tooltip' title='Descartar adjunto'><a href='/adjuntos/descartar_adjunto/#{adjunto_id}' class='btn btn-danger btn-mini' data-method='delete' rel='nofollow'><i class='icon-remove icon-white'></i></a></b>"
  end

  def link_borrar_nota nota_id
	link_to "#", {:class => 'btn btn-mini', :onclick => "return eliminar_nota (#{nota_id})"} do
		html_tag(:i, :class => 'icon-trash icon-black')
	end
  end

end
