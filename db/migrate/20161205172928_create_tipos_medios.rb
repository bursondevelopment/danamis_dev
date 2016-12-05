class CreateTiposMedios < ActiveRecord::Migration
  def change
    create_table :tipos_medios do |t|
      t.string :description

      t.timestamps
    end
  end
end
