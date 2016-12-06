class CreateInformes < ActiveRecord::Migration
  def change
    create_table :informes do |t|
      t.datetime :fecha
      t.string :encabezado
      t.string :titulo
      t.string :autor
      t.string :tema

      t.timestamps
    end
  end
end
