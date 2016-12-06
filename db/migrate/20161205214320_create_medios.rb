class CreateMedios < ActiveRecord::Migration
  def change
    create_table :medios do |t|
      t.string :nombre
      t.string :logo
      t.string :descripcion
      t.integer :impacto
      t.belongs_to :tipo_medio
      t.belongs_to :tipo_especializacion

      t.timestamps
    end
    add_index :medios, :tipo_medio_id
    add_index :medios, :tipo_especializacion_id
  end
end
