class AddInformeEspecialIdToInforme < ActiveRecord::Migration
  def change
    add_column :informes, :informe_especial_id, :integer
    add_index :informes, :informe_especial_id
  end
end
