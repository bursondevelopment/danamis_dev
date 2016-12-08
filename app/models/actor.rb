class Actor < ActiveRecord::Base
  belongs_to :tolda
  belongs_to :organizacion
  attr_accessible :cargo, :nombres, :representante_legal, :organizacion_id, :tolda_id
end
