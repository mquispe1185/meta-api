class AddHabilitadoToComercios < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :habilitado, :boolean, default: false
    add_column :comercios, :envio, :boolean, default: false
  end
end
