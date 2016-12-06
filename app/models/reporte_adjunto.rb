class ReporteAdjunto < ActiveRecord::Base
  belongs_to :reporte
  belongs_to :adjunto
  # attr_accessible :title, :body
end
