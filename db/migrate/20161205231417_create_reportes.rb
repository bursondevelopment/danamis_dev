class CreateReportes < ActiveRecord::Migration
  def change
    create_table :reportes do |t|
      t.string :argumento
      t.string :titulo
      t.string :fecha
      t.belongs_to :autor
      t.belongs_to :informe

      t.timestamps
    end
    add_index :reportes, :autor_id
    add_index :reportes, :informe_id
  end
end
