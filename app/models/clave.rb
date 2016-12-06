class Clave < ActiveRecord::Base
  belongs_to :entorno
  attr_accessible :incluyente, :valor
end
