class MedioOrganizacion < ActiveRecord::Base

  set_primary_keys :medio_id, :organizacion_id
  belongs_to :organizacion
  belongs_to :medio
  attr_accessible :propio, :medio_id, :organizacion_id
end
