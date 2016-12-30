class ChangeArgumentoToReporte < ActiveRecord::Migration
  def up
  	change_column :reportes, :argumento, :text
  end

  def down
  	change_column :reportes, :argumento, :string
  end
end


