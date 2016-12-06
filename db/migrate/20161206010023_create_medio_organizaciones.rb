class CreateMedioOrganizaciones < ActiveRecord::Migration
  def change
    create_table :medio_organizaciones, :id => false do |t|
      t.belongs_to :organizacion
      t.belongs_to :medio
      t.boolean :propio

      t.timestamps
    end
    add_index :medio_organizaciones, :organizacion_id
    add_index :medio_organizaciones, :medio_id
    add_index(:medio_organizaciones, [:medio_id, :organizacion_id], :unique => true)    
  end
end
