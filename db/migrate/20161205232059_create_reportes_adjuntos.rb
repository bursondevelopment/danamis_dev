class CreateReportesAdjuntos < ActiveRecord::Migration
  def change
    create_table :reportes_adjuntos, :id => false do |t|
      t.belongs_to :reporte, :null => false
      t.belongs_to :adjunto, :null => false

      t.timestamps
    end
    add_index :reportes_adjuntos, :reporte_id
    add_index :reportes_adjuntos, :adjunto_id
    add_index(:reportes_adjuntos, [:reporte_id, :adjunto_id], :unique => true)
  end
end