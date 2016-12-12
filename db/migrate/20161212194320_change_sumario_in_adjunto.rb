class ChangeSumarioInAdjunto < ActiveRecord::Migration
  def up
  	change_column :adjuntos, :sumario, :text
  	change_column :adjuntos, :titulo, :text
  end

  def down
  	change_column :adjuntos, :sumario, :string
  	change_column :adjuntos, :titulo, :string
  end
end
