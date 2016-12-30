class AdjuntoOrganizacion < ActiveRecord::Base

  set_primary_keys :adjunto_id, :organizacion_id
  belongs_to :organizacion
  belongs_to :adjunto
  attr_accessible :adjunto_id, :organizacion_id
end
