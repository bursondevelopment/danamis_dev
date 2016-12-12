class EstructuraMedio < ActiveRecord::Base
  attr_accessible :articulo, :contenido, :fecha, :imagen, :titulo, :url, :medio_id

  belongs_to :medio
  accepts_nested_attributes_for :medio


  require 'uri'
  require 'mechanize'


  def importar_notas 
    index = cargar_website url
    notas_web = index.search articulo

    adjuntos_cargados = 0

    notas_web.each do |nota_web|
      # Creación del Hash para la Nota
      nota_temp = Hash.new
      nota_temp[:medio_id] = medio_id
#      nota_temp[:tipo_nota_id] = 1

      # Gestión de titulo y url
      nota_temp[:titulo] = nota_web.search(titulo).first

      unless nota_temp[:titulo].blank?
        nota_temp[:url] = (nota_temp[:titulo].attr "href")
        nota_temp[:url].slice! 0 if (nota_temp[:url][0].eql? "/")
        nota_temp[:url] = medio.url+nota_temp[:url] if !(nota_temp[:url].include? medio.descripcion)
        
        unless nota_temp[:titulo].blank?
          titulo_temp = nota_temp[:titulo].text
          titulo_temp = nota_temp[:titulo].attr "title" if titulo_temp.blank?
          nota_temp[:titulo] = limpio titulo_temp
          # nota_temp[:titulo] = nota_temp[:titulo].toutf8
        end

      end

      # Gestión de Resumen de la nota
      nota_temp[:sumario] = nota_web.search(contenido).text



      # Gestión de la Imagen

=begin
      nota_temp[:imagen] = nota_web.search(imagen)
      # nota_temp[:imagen] = (nota_temp[:imagen].attr "src").text unless nota_temp[:imagen].blank? or !(nota_temp[:imagen].attr "src")

      unless nota_temp[:imagen].blank?
        aux = nota_temp[:imagen].attr "data-src"
        unless aux.blank?
          nota_temp[:imagen] = aux.text
        else
          aux = nota_temp[:imagen].attr "src"
          nota_temp[:imagen] = aux.value if aux
        end
      end

      nota_temp[:imagen] = nota_temp[:imagen].to_s
      nota_temp[:imagen] = url_limpio nota_temp[:imagen]
      puts "IMAGEN: #{nota_temp[:imagen]}"
      nota_temp[:imagen] = website.url+nota_temp[:imagen] if !nota_temp[:imagen].blank? and !(nota_temp[:imagen].include? website.descripcion)
      nota_temp[:imagen] = nil if nota_temp[:imagen].eql? "http://anonymouse.org/images/stop.gif"
=end
      # Gestión de la Fecha de publicación
      fecha_temp = nota_web.search(fecha).first
      nota_temp[:fecha] = fecha_temp.text unless fecha_temp.blank?

      # Crear Adjunto
      adjunto = Adjunto.new nota_temp

      puts "".center(100,"-")
      puts nota_temp
      puts "Nota: #{adjunto.id}"
      puts "Titular: #{adjunto.titulo}"
      puts "url: #{adjunto.url}"
      puts "sumario: #{adjunto.sumario}"
#      puts "imagen: #{adjunto.imagen}"      
      puts adjunto.save
      puts "".center(100,"-")

      adjuntos_cargados +=1 if adjunto.save
    end
    puts " Resumen en #{url}: ".center(100,"=")
    puts "Total de Notas a Cargar: #{notas_web.count}"
    puts "Total de Notas Cargadas: #{adjuntos_cargados}"
    puts "".center(100,"=")
    return adjuntos_cargados
  end
  
  def limpio text
    text.gsub(/[\t\n\r]/, '')
  end

  def url_limpio text
    text.gsub(/[\t\n\r\ ]/, '')
  end

  def cargar_website dir_url
    dir_url = URI.parse dir_url
    agente = Mechanize.new
    # Importante para los tiempos
      agente.open_timeout = 10
      agente.read_timeout = 10
    begin
      return agente.get(dir_url)
    rescue Exception => ex
      return ex
    end
  end

end
