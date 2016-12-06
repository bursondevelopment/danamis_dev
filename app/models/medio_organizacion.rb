class MedioOrganizacion < ActiveRecord::Base
  belongs_to :organizacion
  belongs_to :medio
  attr_accessible :propio
end
