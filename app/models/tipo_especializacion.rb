class TipoEspecializacion < ActiveRecord::Base
  attr_accessible :description

  has_many :medios
  accepts_nested_attributes_for :medios

  def descripcion
  	description
  end

end
