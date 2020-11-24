class AddImporteToPromociones < ActiveRecord::Migration[5.2]
  def change
    add_column :promociones, :importe, :decimal, default: 0
    add_column :promociones, :costo_diario, :decimal, default: 0
    add_column :promociones, :descuento, :decimal, default: 0
    add_column :promociones, :codigo, :string
    change_column_default :promociones, :estado, 0
  end
end
