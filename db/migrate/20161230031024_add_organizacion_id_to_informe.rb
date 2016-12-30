class AddOrganizacionIdToInforme < ActiveRecord::Migration
  def change
    add_column :informes, :organizacion_id, :integer
    add_index :informes, :organizacion_id
  end
end
