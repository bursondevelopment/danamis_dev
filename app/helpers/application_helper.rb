# encoding: UTF-8
module ApplicationHelper
  # def carga_reciente? website
  #   tiempo_retardo = 10 #minutos
  #   nota = website.notas.last 
  #   tiempo_ultima_carga = (nota.updated_at - DateTime.now) / 60
  #   tiempo_ultima_carga = tiempo_ultima_carga*-1 if tiempo_ultima_carga < 0
  #   return tiempo_ultima_carga < tiempo_retardo
  # end
  # 
  # def importar_notas_website nombre
  #   Importer.import_notas_noticias24 if nombre.eql? "noticias24"
  #   Importer.import_notas_globovision if nombre.eql? "globovision"
  #   Importer.import_notas_union_radio if nombre.eql? "unionradio"
  #   Importer.import_notas_noticierodigital if nombre.eql? "noticierodigital"
  #   Importer.import_notas_noticierovenevision if nombre.eql? "noticierovenevision"
  #   Importer.import_notas_vtv if nombre.eql? "vtv"
  #   Importer.import_notas_laverdad if nombre.eql? "laverdad"
  #   Importer.import_notas_informe21 if nombre.eql? "informe21"
  #   Importer.import_notas_eluniversal if nombre.eql? "eluniversal"
  #   Importer.import_notas_avn if nombre.eql? "avn"
  #   Importer.import_notas_elnacional if nombre.eql? "elnacional"
  #   Importer.import_notas_rnv if nombre.eql? "rnv"
  #   Importer.import_notas_radiomundial if nombre.eql? "radiomundial"
  #   
  # end

  def btn_mini titulo_tooltip, url, tipo_btn, icon_btn
    " <b class='tooltip-btn' data_toggle='tooltip' title='#{titulo_tooltip}'><a href='#{url}' class='btn #{tipo_btn} btn-mini'><i class='#{icon_btn} icon-white'></i></a></b>"
  end


  def btn_icon titulo_tooltip, btn_titulo, url, tipo_btn, icon_btn
    " <b class='tooltip-btn' data_toggle='tooltip' title='#{titulo_tooltip}'><a href='#{url}' class='btn #{tipo_btn}'>#{btn_titulo}<i class='#{icon_btn} icon-white'></i></a></b>"
  end


  def btn_mini_del titulo_tooltip, url, tipo_btn, icon_btn, msg='¿Estas Seguro?'

    " <b class='tooltip-btn' data_toggle='tooltip' title='#{titulo_tooltip}'><a href='#{url}' class='btn #{tipo_btn} btn-mini' data-confirm='#{msg}' data-method='delete' rel='nofollow'><i class='#{icon_btn} icon-white'></i></a></b>"
  end




  def link_to_nota nota
    link_to nota.website.descripcion, nota.url, {:class => 'btn btn-link', :target => '_blank'}
  end

  def importar_notas_websites
    require "Importer"
    Importer.import_notas_noticias24
    Importer.import_notas_globovision
    Importer.import_notas_union_radio
    Importer.import_notas_noticierodigital
    Importer.import_notas_noticierovenevision
    Importer.import_notas_vtv
    Importer.import_notas_laverdad
    Importer.import_notas_informe21
    Importer.import_notas_eluniversal
    Importer.import_notas_avn
    Importer.import_notas_elnacional
    Importer.import_notas_rnv
    Importer.import_notas_radiomundial

  end
  
  def limpiar_notas_antiguas_inservibles
    Nota.delete_all (["resumen_id IS ? AND created_at <= ?", nil, Date.today])
  end
  
  def flash_class(level)
      case level
          when :notice then "alert alert-info"
          when :success then "alert alert-success"
          when :error then "alert alert-error"
          when :alert then "alert alert-error"
      end
  end

end
