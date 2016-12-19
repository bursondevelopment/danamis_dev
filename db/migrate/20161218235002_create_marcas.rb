class CreateMarcas < ActiveRecord::Migration
  def change
    create_table :marcas do |t|
      t.string :nombre
      t.belongs_to :organizacion

      t.timestamps
    end
    add_index :marcas, :organizacion_id
  end
end
