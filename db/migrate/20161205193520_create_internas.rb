class CreateInternas < ActiveRecord::Migration
  def change
    create_table :internas do |t|
      t.string :description

      t.timestamps
    end
  end
end
