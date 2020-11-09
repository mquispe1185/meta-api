class AddHabilitadoToComercios < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :habilitado, :boolean, default: false
    add_column :comercios, :envio, :boolean, default: false
    add_column :comercios, :tipo_servicio, :integer, default: 0
    add_column :comercios, :visitas, :integer, default: 0
  end
end
