class Entorno < ActiveRecord::Base
  attr_accessible :nombre


  has_many :claves
  accepts_nested_attributes_for :claves
end
