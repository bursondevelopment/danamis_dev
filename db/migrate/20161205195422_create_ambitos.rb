class CreateAmbitos < ActiveRecord::Migration
  def change
    create_table :ambitos do |t|
      t.string :description

      t.timestamps
    end
  end
end
