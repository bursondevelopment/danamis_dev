class CreateOrganizaciones < ActiveRecord::Migration
  def change
    create_table :organizaciones do |t|
      t.string :razon_social
      t.belongs_to :entorno
      t.belongs_to :interna
      t.belongs_to :externa
      t.belongs_to :ambito
      t.belongs_to :clase

      t.timestamps
    end
    add_index :organizaciones, :entorno_id
    add_index :organizaciones, :interna_id
    add_index :organizaciones, :externa_id
    add_index :organizaciones, :ambito_id
    add_index :organizaciones, :clase_id
  end
end
