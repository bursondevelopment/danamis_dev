class InformeMailer < ActionMailer::Base
  default from: "Burson Marsteller"
  
  def enviar_informe(informe_id, correos)

    @informe = Informe.find (informe_id)

    @reportes_cliente = @informe.reportes.clientes.order('orden ASC')
    @reportes_competencias = @informe.reportes.competencias.order('orden ASC')
    @reportes_actividad = @informe.reportes.actividad.order('orden ASC')
    @reportes_impresos = @informe.reportes.impresos.order('orden ASC')

    @informe_especial = @informe.informe_especial
    @errores_adjuntos = 0
    @total_adjuntos = 0


    begin
      @reportes_impresos.each do |reporte|
        reporte.adjuntos.each do |adjunto|
          if adjunto.impreso?
                attachments.inline[adjunto.nombre_mail] = File.read(adjunto.url)
                @total_adjuntos += 1
          end
        end
      end
      puts "Total de adjuntos".center(100, "=")
      puts "<#{@total_adjuntos}>"
      puts "Final".center(100, "=")
    rescue Exception => e
        puts "Error".center(100, "=")
        puts "#{e}".center(100, "=")
        puts @errores_adjuntos += 1
    end
#imagen_url

#/home/daniel/bmvzla/danamis_dev/app/assets/images/adjuntos/adjunto_12877_medio_187.png


    begin
        attachments.inline["logo_#{@informe.organizacion.razon_social}.png"] = File.read("#{Rails.root}/app/assets/images/logos/logo_#{@informe.organizacion.razon_social}.png")    
    rescue
        @no_logo = true
    end



    titulo = "#{@informe.created_at.strftime("%d-%m-%Y")} #{@informe.titulo}"
    mail(to: correos, subject: @informe.titulo, from: 'BMMonitoringRoom1@BM.com')
    
  end
end
