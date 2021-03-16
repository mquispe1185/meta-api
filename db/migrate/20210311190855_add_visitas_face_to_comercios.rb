class AddVisitasFaceToComercios < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :visitas_face, :integer, default: 0
    add_column :comercios, :visitas_ig, :integer, default: 0
    add_column :comercios, :visitas_web, :integer, default: 0
    add_column :comercios, :visitas_wsp, :integer, default: 0
    add_column :promociones, :vistas, :integer, default: 0
  end
end
