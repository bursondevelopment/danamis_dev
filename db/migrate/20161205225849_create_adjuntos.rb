class CreateAdjuntos < ActiveRecord::Migration
  def change
    create_table :adjuntos do |t|
      t.string :titulo
      t.string :sumario
      t.string :fecha
      t.string :autor
      t.belongs_to :medio

      t.timestamps
    end
    add_index :adjuntos, :medio_id
  end
end
