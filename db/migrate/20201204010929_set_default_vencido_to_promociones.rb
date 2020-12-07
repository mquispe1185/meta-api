class SetDefaultVencidoToPromociones < ActiveRecord::Migration[5.2]
  def change
    change_column_default :promociones, :vencido, false
  end
end
