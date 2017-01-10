class AddTipoToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :tipo, :integer
  end
end
