class AddEstadoToComercio < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :estado, :integer, default: 0
  end
end
