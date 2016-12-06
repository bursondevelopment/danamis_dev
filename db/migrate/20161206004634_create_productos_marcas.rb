class CreateProductosMarcas < ActiveRecord::Migration
  def change
    create_table :productos_marcas, :id => false do |t|
      t.belongs_to :producto
      t.belongs_to :marca

      t.timestamps
    end
    add_index :productos_marcas, :producto_id
    add_index :productos_marcas, :marca_id
    add_index(:productos_marcas, [:producto_id, :marca_id], :unique => true)    
  end
end
