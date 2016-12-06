class Reporte < ActiveRecord::Base
  belongs_to :autor
  belongs_to :informe
  attr_accessible :argumento, :fecha, :titulo
end
