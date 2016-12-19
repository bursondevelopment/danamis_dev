class ProductoMarca < ActiveRecord::Base

  set_primary_keys :producto_id, :marca_id

  belongs_to :producto
  accepts_nested_attributes_for :producto 

  belongs_to :marca
  accepts_nested_attributes_for :marca
  
  attr_accessible :producto_id, :marca_id

end
