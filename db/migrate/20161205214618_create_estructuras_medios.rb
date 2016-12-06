class CreateEstructurasMedios < ActiveRecord::Migration
  def change
    create_table :estructuras_medios do |t|
      t.string :url
      t.string :articulo
      t.string :titulo
      t.string :contenido
      t.string :imagen
      t.string :fecha
      t.belongs_to :medio

      t.timestamps
    end
    add_index :estructuras_medios, :medio_id
  end
end
