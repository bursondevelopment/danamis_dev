class AddValidaToAdjunto < ActiveRecord::Migration
  def change
    add_column :adjuntos, :valida, :boolean, :default => false
  end
end
