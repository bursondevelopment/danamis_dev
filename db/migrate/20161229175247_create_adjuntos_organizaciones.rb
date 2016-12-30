class CreateAdjuntosOrganizaciones < ActiveRecord::Migration
  def change
    create_table :adjunto_organizaciones, :id => false do |t|
      t.belongs_to :organizacion
      t.belongs_to :adjunto
      t.timestamps
    end
    add_index :adjunto_organizaciones, :organizacion_id
    add_index :adjunto_organizaciones, :adjunto_id
    add_index(:adjunto_organizaciones, [:adjunto_id, :organizacion_id], :unique => true)    
  end
end
