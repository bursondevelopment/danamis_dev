class CreateTipoEspecializaciones < ActiveRecord::Migration
  def change
    create_table :tipo_especializaciones do |t|
      t.string :description

      t.timestamps
    end
  end
end
