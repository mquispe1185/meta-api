class AddServicioAnteriorToComercioPlan < ActiveRecord::Migration[5.2]
  def change
    add_reference :comercioplanes, :servicio_anterior, foreign_key: { to_table: :tipo_servicios }
    add_column :comercioplanes, :meses, :integer, default: 0
  end
end
