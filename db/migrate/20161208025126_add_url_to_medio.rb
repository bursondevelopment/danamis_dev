class AddUrlToMedio < ActiveRecord::Migration
  def change
    add_column :medios, :url, :string
  end
end
