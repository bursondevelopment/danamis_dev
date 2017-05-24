# encoding: utf-8
class Pdf
  require 'iconv'
  def self.to_utf16(valor)
    ic_ignore = Iconv.new('ISO-8859-15//IGNORE//TRANSLIT', 'UTF-8')
    ic_ignore.iconv(valor)
  end
  
  def self.descargar_reportes_excel
    require 'spreadsheet'
    @book = Spreadsheet::Workbook.new
    @sheet = @book.create_worksheet :name => "Reporte"
    # @sheet = @book.create_worksheet :name => "reporte de alertas#{DateTime.now.strftime('%d %m %Y %h')}"
    data = %w{ID CLIENTE TITULO ARGUMENTO PALABRAS_CLAVES MEDIO AUTOR URL_NOTA ACTOR FECHA SUBTIPO_MEDIO CPM VPE}

    @sheet.row(0).concat data
    reportes = Reporte.order('created_at DESC').limit(500)

    data = []
    indice = 0
    reportes.each_with_index do |reporte,i|
      cliente = reporte.organizacion.razon_social if reporte.organizacion
      reporte.adjuntos.each_with_index do |adjunto,j|
        actor_aux = reporte.actor.nombres_cargo if reporte.actor  
        aux = {"ID" => reporte.id, "CLIENTE" => cliente, "TITULO" => reporte.titulo, "ARGUMENTO" => reporte.argumento, "PALABRAS_CLAVES" => reporte.palabras_claves, "MEDIO" => adjunto.medio.descripcion, "AUTOR" => adjunto.autor, "URL_NOTA" => adjunto.url, "ACTOR" => actor_aux, "FECHA" => adjunto.created_at.to_date, "SUBTIPO_MEDIO" => adjunto.medio.tipo_especializacion.descripcion, "CPM" => 245, "VPE" => adjunto.medio.impacto}
          indice += 1
        @sheet.row(indice).concat aux.values
      end
    end
    file_name = "Reporte Unidades Informativas #{DateTime.now.strftime('%d_%m_%Y_%H_%M')}.xls"
    return file_name if @book.write file_name
    
  end
  

  def self.generar(informe_id)
    @informe = Informe.find informe_id

    pdf = PDF::Writer.new
    pdf.margins_cm(1.8)
    #color de relleno para el pdf (color de las letras)
#    pdf.fill_color(Color::RGB.new(255,255,255))
    #imagen del encabezado
 #   pdf.add_image_from_file 'app/assets/images/banner.jpg', 50, 685, 510, 60
 
    ss = PDF::Writer::StrokeStyle.new(2)
    ss.cap = :round
    pdf.stroke_style ss   
    
    #pdf.add_image_from_file 'app/assets/images/logo_fhe_ucv.jpg', 465, 710, 50,nil
#    pdf.add_image_from_file 'app/assets/images/logo_eim.jpg', 515, 710+10, 50,nil
#    pdf.add_image_from_file 'app/assets/images/logo_ucv.jpg', 45, 710, 50,nil
 


  
    
    pdf.select_font "Helvetica"
   
    
    #texto del encabezado

    pdf.text to_utf16("#{@informe.organizacion.razon_social}"), :font_size => 14,:justification => :center
    pdf.text to_utf16("#{@informe.autor}"), :font_size => 12,:justification => :center
    pdf.text to_utf16("#{@informe.fecha}"), :font_size => 12,:justification => :center, :backgroud_color => (Color::RGB.new(0,0,0)), :font_color => (Color::RGB.new(255,255,255))
    pdf.text to_utf16("#{@informe.titulo}"), :font_size => 12,:justification => :center

    pdf.line 35,650,575,700
    pdf.text "\n\n"
    pdf.text to_utf16("#{@informe.encabezado}"), :font_size => 12,:justification => :center
    pdf.line 45,650,575,700

    @clientes = @informe.reportes.clientes

    pdf.link("dddd",70,650,575,700) 

    return pdf

  end

end