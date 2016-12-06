class CreateEntornos < ActiveRecord::Migration
  def change
    create_table :entornos do |t|
      t.string :nombre, :unique => true

      t.timestamps
    end
  end
end
