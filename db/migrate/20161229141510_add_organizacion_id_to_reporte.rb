class AddOrganizacionIdToReporte < ActiveRecord::Migration
  def change
    add_column :reportes, :organizacion_id, :integer
    add_index :reportes, :organizacion_id

  end
end
