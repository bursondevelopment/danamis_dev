class InformeMailer < ActionMailer::Base
  default from: "Burson Marsteller"
  
  def enviar_informe(informe_id, correos)

    @informe = Informe.find (informe_id)

    #@informe = Informe.where(:id => informe_id).limit(1).first
    #@resumenes = @informe.resumenes.order(:orden)

    #temas_id = Tema.joins(:resumenes).where('resumenes.informe_id = ?', @informe.id)
    #@asuntos = Asunto.joins(:temas).where('temas.id' => temas_id).group(:id)
    #@asuntos = @asuntos.joins(:informes_asuntos).where('informes_asuntos.informe_id' => @informe.id).order(:orden)
    #@informes_temas = InformeTema.where(:informe_id => @informe.id).order(:orden)
    #@informes_asuntos = InformeAsunto.where(:informe_id => @informe.id).order(:orden)    
    #@correos = Usuario.all.collect{|u| u.correo}

    titulo = "#{@informe.created_at.strftime("%d-%m-%Y")} #{@informe.titulo}"
    mail(to: correos, subject: @informe.titulo)
    
  end
end
