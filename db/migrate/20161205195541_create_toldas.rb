class CreateToldas < ActiveRecord::Migration
  def change
    create_table :toldas do |t|
      t.string :description

      t.timestamps
    end
  end
end
