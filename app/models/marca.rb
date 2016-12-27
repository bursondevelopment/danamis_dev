class Marca < ActiveRecord::Base
  belongs_to :organizacion
  attr_accessible :nombre, :organizacion_id

  has_many :productos_marcas
  accepts_nested_attributes_for :productos_marcas

  has_and_belongs_to_many :productos, :join_table => "productos_marcas"
  accepts_nested_attributes_for :productos

  validates_presence_of :nombre, :organizacion_id
  validates :nombre, :uniqueness => true

end
