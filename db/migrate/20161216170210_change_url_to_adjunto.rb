class ChangeUrlToAdjunto < ActiveRecord::Migration
  def up
  	change_column :adjuntos, :url, :text
  end

  def down
  	change_column :adjuntos, :url, :text
  end
end
