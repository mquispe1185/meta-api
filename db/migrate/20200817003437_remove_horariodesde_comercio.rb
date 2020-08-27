class RemoveHorariodesdeComercio < ActiveRecord::Migration[5.2]
  def change
    remove_column :comercios, :horario_desde
    remove_column :comercios, :horario_hasta
    remove_column :comercios, :horario_desde2
    remove_column :comercios, :horario_hasta2
  end
end
