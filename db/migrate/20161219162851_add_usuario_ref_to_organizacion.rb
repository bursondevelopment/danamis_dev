class AddUsuarioRefToOrganizacion < ActiveRecord::Migration
  def change
    add_column :organizaciones, :usuario_id, :integer
    add_index :organizaciones, :usuario_id
    
  end
end
