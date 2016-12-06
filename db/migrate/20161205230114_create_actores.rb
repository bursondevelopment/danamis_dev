class CreateActores < ActiveRecord::Migration
  def change
    create_table :actores do |t|
      t.string :nombres
      t.string :cargo
      t.belongs_to :tolda
      t.belongs_to :organizacion
      t.boolean :representante_legal

      t.timestamps
    end
    add_index :actores, :tolda_id
    add_index :actores, :organizacion_id
  end
end
