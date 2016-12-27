class Organizacion < ActiveRecord::Base
  belongs_to :entorno
  belongs_to :interna
  belongs_to :externa
  belongs_to :ambito
  belongs_to :clase
  belongs_to :usuario

  attr_accessible :razon_social, :entorno_id, :interna_id, :externa_id, :ambito_id, :clase_id, :usuario_id


  has_and_belongs_to_many :medios, :join_table => "medio_organizaciones"
  accepts_nested_attributes_for :medios

=begin
  has_and_belongs_to_many :medio_organizaciones
  accepts_nested_attributes_for :medio_organizaciones
=end

  #scope :productos, joins(:producto_marca).where('productos_marcas.marca.organizacion_id = ?', id)

  def descripcion
    aux = razon_social
    aux += ": #{actores.count} actores"
    aux += ", #{marcas.count} marcas-productos"
    aux += " y #{medios.count} medios"

  end

  def productos
    productos = Producto.where('1=0')

    marcas.each do |marca|
    productos += marca.productos 
    end

    return productos
    #joins(:productos)#.where('marcas.organizacion_id = ?', id)
  end


  has_many :actores
  accepts_nested_attributes_for :actores

  has_many :marcas
  accepts_nested_attributes_for :marcas


  validates_presence_of :razon_social, :interna_id, :externa_id, :ambito_id, :clase_id
  validates :razon_social, :uniqueness => true

  scope :clientes, joins(:interna).where("description = 'Cliente'")

  def competencia
    entorno.organizaciones.where('id != ?', id)
  end

end
