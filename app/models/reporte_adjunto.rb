class ReporteAdjunto < ActiveRecord::Base

  set_primary_keys :reporte_id, :adjunto_id

  belongs_to :reporte
  belongs_to :adjunto

  attr_accessible :reporte_id, :adjunto_id

  validates :reporte_id, :uniqueness => {:scope => :adjunto_id}

end
