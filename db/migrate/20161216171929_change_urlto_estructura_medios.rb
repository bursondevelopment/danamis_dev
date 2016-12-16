class ChangeUrltoEstructuraMedios < ActiveRecord::Migration
  def up
  	change_column :estructuras_medios, :url, :text
  end

  def down
  	change_column :estructuras_medios, :url, :text
  end
end
