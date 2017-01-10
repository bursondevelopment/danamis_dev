class Actor < ActiveRecord::Base
  belongs_to :tolda
  belongs_to :organizacion
  attr_accessible :cargo, :nombres, :representante_legal, :organizacion_id, :tolda_id

  def descripcion
  	aux = nombres
  	aux += " - #{cargo} " if cargo
  	aux += " (#{organizacion.razon_social})" if organizacion

  	return aux
  end

  def string_humanize palabras
  	aux = ""
  	palabras.split.each do |pal|
  		aux += "#{pal.humanize} "
  	end
  	return aux
  end

  def nombres_cargo
  	aux = nombres
  	aux += " (#{cargo})" if cargo
  	return aux.upcase
  end 

end
