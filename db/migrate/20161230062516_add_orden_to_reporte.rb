class AddOrdenToReporte < ActiveRecord::Migration
  def change
    add_column :reportes, :orden, :integer
  end
end
