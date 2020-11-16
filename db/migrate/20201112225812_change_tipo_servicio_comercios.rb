class ChangeTipoServicioComercios < ActiveRecord::Migration[5.2]
  def change
    remove_column :comercios, :tipo_servicio
    add_reference :comercios, :tipo_servicio, foreign_key: true
  end
end
