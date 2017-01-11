class InformeMailer < ActionMailer::Base
  default from: "Burson Marsteller"
  
  def enviar_informe(informe_id, correos)

    @informe = Informe.find (informe_id)
    @informe_especial = @informe.informe_especial

    begin
        attachments.inline["logo_#{@informe.organizacion.razon_social}.png"] = File.read("#{Rails.root}/app/assets/images/logos/logo_#{@informe.organizacion.razon_social}.png")    
    rescue
        @no_logo = true
    end
    titulo = "#{@informe.created_at.strftime("%d-%m-%Y")} #{@informe.titulo}"
    mail(to: correos, subject: @informe.titulo)
    
  end
end
