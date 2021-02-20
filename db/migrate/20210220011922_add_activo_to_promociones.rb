class AddActivoToPromociones < ActiveRecord::Migration[5.2]
  def change
    add_column :promociones, :activo, :boolean, default: true
  end
end
