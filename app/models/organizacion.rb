class Organizacion < ActiveRecord::Base
  belongs_to :entorno
  belongs_to :interna
  belongs_to :externa
  belongs_to :ambito
  belongs_to :clase
  belongs_to :usuario

  CONTEXTO_PAIS_ID = 571 #83 en local y 571 en Servidor
  attr_accessible :razon_social, :entorno_id, :interna_id, :externa_id, :ambito_id, :clase_id, :usuario_id

  has_and_belongs_to_many :medios, :join_table => "medio_organizaciones"
  accepts_nested_attributes_for :medios

  has_many :medio_organizaciones, :dependent => :destroy
  accepts_nested_attributes_for :medio_organizaciones

  has_many :adjunto_organizaciones, :dependent => :destroy
  accepts_nested_attributes_for :adjunto_organizaciones

  has_and_belongs_to_many :adjuntos, :join_table => "adjunto_organizaciones"
  accepts_nested_attributes_for :adjuntos

  has_many :actores
  accepts_nested_attributes_for :actores

  has_many :marcas
  accepts_nested_attributes_for :marcas

  has_many :reportes
  accepts_nested_attributes_for :reportes

  has_many :informes, :dependent => :destroy
  accepts_nested_attributes_for :informes  

  validates_presence_of :razon_social, :interna_id, :externa_id, :ambito_id, :clase_id, :entorno_id
  validates :razon_social, :uniqueness => true

  scope :clientes, joins(:interna).where("description = 'Cliente'")

  def productos
    productos = Producto.where('1=0')

    marcas.each do |marca|
    productos += marca.productos 
    end

    return productos
    #joins(:productos)#.where('marcas.organizacion_id = ?', id)
  end

  def descripcion
    aux = razon_social
    aux += ": #{actores.count} actores"
    aux += ", #{marcas.count} marcas-productos"
    aux += " y #{medios.count} medios"

  end

  def competencia
    entorno.organizaciones.where('id != ?', id)
  end

end
