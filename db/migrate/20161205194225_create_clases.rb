class CreateClases < ActiveRecord::Migration
  def change
    create_table :clases do |t|
      t.string :description

      t.timestamps
    end
  end
end
