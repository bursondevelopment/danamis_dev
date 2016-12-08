class TipoMedio < ActiveRecord::Base
  attr_accessible :description

  has_many :medios
  accepts_nested_attributes_for :medios

end
