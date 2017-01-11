class Informe < ActiveRecord::Base
  belongs_to :organizacion

  attr_accessible :autor, :encabezado, :fecha, :tema, :titulo, :organizacion_id, :informe_especial_id

  belongs_to :informe_especial, class_name: 'Informe', foreign_key: 'informe_especial_id'
  accepts_nested_attributes_for :informe_especial

  has_many :reportes
  accepts_nested_attributes_for :reportes

  scope :creados_hoy, -> {where("created_at >= ?", Date.today)}

  validates_presence_of :fecha, :titulo, :organizacion_id


  def tiene_informe_especial?
  	if informe_especial_id.nil?
  		return false
  	else
  		true
  	end

  end
end
