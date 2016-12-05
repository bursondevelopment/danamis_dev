class CreateEspecializacionesMedio < ActiveRecord::Migration
  def change
    create_table :especializaciones_medio do |t|

      t.timestamps
    end
  end
end
