class RenameImpactoToVpe < ActiveRecord::Migration
  def change
  	rename_column :medios, :impacto, :vpe
  end
end
