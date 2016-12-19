class Producto < ActiveRecord::Base
  attr_accessible :descripcion, :nombre

  has_and_belongs_to_many :marcas, :join_table => "productos_marcas"
  accepts_nested_attributes_for :marcas

  validates_presence_of :nombre
  validates :nombre, :uniqueness => true



  def descripcion_completa
  	aux = "#{nombre}"
  	aux += " - #{descripcion}" if descripcion
  	return aux
  end
end
