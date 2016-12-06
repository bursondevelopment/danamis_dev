class ProductoMarca < ActiveRecord::Base
  belongs_to :producto
  belongs_to :marca
  # attr_accessible :title, :body
end
