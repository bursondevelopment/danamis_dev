class Medio < ActiveRecord::Base
  belongs_to :tipo_medio
  belongs_to :tipo_especializacion
  attr_accessible :descripcion, :vpe, :logo, :nombre, :url, :tipo_medio_id, :tipo_especializacion_id

  validates_presence_of :nombre, :url, :vpe, :descripcion, :tipo_medio_id, :tipo_especializacion_id
  validates :url, :uniqueness => true

  has_and_belongs_to_many :organizaciones, :join_table => "medio_organizaciones"
  accepts_nested_attributes_for :organizaciones

  has_many :medio_organizaciones, :dependent => :destroy
  accepts_nested_attributes_for :medio_organizaciones


  def impacto
    vpe*246
  end
  has_many :adjuntos
  accepts_nested_attributes_for :adjuntos

  has_many :estructura_medios
  accepts_nested_attributes_for :estructura_medios


  def importar_notas_medios_web
    total = 0
    begin
      estructura_medios.each do |estructura_medio|
        total = estructura_medio.importar_notas
      end
      return total
    rescue Exception => ex
      return ex
    end
  end


end
