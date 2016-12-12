class AddUrlToAdjunto < ActiveRecord::Migration
  def change
    add_column :adjuntos, :url, :string
  end
end
