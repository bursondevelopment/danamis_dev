class AddSeccionToReporte < ActiveRecord::Migration
  def change
    add_column :reportes, :seccion, :string
  end
end
