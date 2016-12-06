class CreateClaves < ActiveRecord::Migration
  def change
    create_table :claves do |t|
      t.string :valor
      t.boolean :incluyente
      t.belongs_to :entorno

      t.timestamps
    end
    add_index :claves, :entorno_id
  end
end
