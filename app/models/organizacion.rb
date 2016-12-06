class Organizacion < ActiveRecord::Base
  belongs_to :entorno
  belongs_to :interna
  belongs_to :externa
  belongs_to :ambito
  belongs_to :clase
  attr_accessible :razon_social
end
