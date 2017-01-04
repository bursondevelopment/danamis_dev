class Informe < ActiveRecord::Base
  belongs_to :organizacion

  attr_accessible :autor, :encabezado, :fecha, :tema, :titulo, :organizacion_id

  has_many :reportes
  accepts_nested_attributes_for :reportes

  scope :creados_hoy, -> {where("created_at >= ?", Date.today)}

  validates_presence_of :fecha, :titulo, :organizacion_id

end
