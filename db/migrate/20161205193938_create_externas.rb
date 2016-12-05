class CreateExternas < ActiveRecord::Migration
  def change
    create_table :externas do |t|
      t.string :description

      t.timestamps
    end
  end
end
