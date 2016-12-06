class EstructuraMedio < ActiveRecord::Base
  belongs_to :medio
  attr_accessible :articulo, :contenido, :fecha, :imagen, :titulo, :url
end
