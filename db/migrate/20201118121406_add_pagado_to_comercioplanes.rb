class AddPagadoToComercioplanes < ActiveRecord::Migration[5.2]
  def change
    add_column :comercioplanes, :pagado, :boolean, default: false
    add_column :comercioplanes, :codigo, :string
  end
end
