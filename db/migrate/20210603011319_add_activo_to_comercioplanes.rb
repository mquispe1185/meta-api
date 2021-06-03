class AddActivoToComercioplanes < ActiveRecord::Migration[5.2]
  def change
    add_column :comercioplanes, :activo, :boolean, default: true
  end
end
