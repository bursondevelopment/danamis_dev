class Organizacion < ActiveRecord::Base
  belongs_to :entorno
  belongs_to :interna
  belongs_to :externa
  belongs_to :ambito
  belongs_to :clase
  attr_accessible :razon_social, :entorno_id, :interna_id, :externa_id, :ambito_id, :clase_id

  has_many :actores
  accepts_nested_attributes_for :actores

end
