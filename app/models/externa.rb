class Externa < ActiveRecord::Base
  attr_accessible :description

  has_many :organizaciones
  accepts_nested_attributes_for :organizaciones
end
