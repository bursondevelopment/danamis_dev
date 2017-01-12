class AddMedicionToMedio < ActiveRecord::Migration
  def change
    add_column :medios, :medicion, :integer
  end
end
