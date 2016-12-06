class Medio < ActiveRecord::Base
  belongs_to :tipo_medio
  belongs_to :tipo_especializacion
  attr_accessible :descripcion, :impacto, :logo, :nombre
end
