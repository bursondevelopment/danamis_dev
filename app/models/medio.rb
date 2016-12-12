class Medio < ActiveRecord::Base
  belongs_to :tipo_medio
  belongs_to :tipo_especializacion
  attr_accessible :descripcion, :impacto, :logo, :nombre, :url, :tipo_medio_id, :tipo_especializacion_id

  validates_presence_of :nombre, :url, :impacto, :descripcion, :tipo_medio_id, :tipo_especializacion_id
  validates :url, :uniqueness => true


  has_many :adjuntos
  accepts_nested_attributes_for :adjuntos

  has_many :estructura_medios
  accepts_nested_attributes_for :estructura_medios


end
