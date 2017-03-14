class Medio < ActiveRecord::Base
  belongs_to :tipo_medio
  belongs_to :tipo_especializacion
  attr_accessible :descripcion, :vpe, :logo, :nombre, :url, :tipo_medio_id, :tipo_especializacion_id, :medicion

  validates_presence_of :nombre, :vpe, :descripcion, :tipo_medio_id, :tipo_especializacion_id

  validates_presence_of :url, if: :digital?

  #validates_presence_of :medicion, if: :digital?


  validates :url, :uniqueness => true, if: :digital?

  has_and_belongs_to_many :organizaciones, :join_table => "medio_organizaciones"
  accepts_nested_attributes_for :organizaciones

  has_many :medio_organizaciones, :dependent => :destroy
  accepts_nested_attributes_for :medio_organizaciones

  scope :digitales, joins(:tipo_medio).where("tipos_medios.description = 'digital'")

  scope :impresos, joins(:tipo_medio).where("tipos_medios.description = 'impreso'")

  # El impacto (roi) es un valor asociado al cliente 
  def impacto
    vpe*245
  end

  def digital?
    tipo_medio.description.eql? 'digital'
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
      return total
    end
  end


end
