class AddActorIdToReporte < ActiveRecord::Migration
  def change
    add_column :reportes, :actor_id, :integer
    add_index :reportes, :actor_id
    #del_column :reportes, :autor_id
  end
end
