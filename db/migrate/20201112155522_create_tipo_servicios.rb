class CreateTipoServicios < ActiveRecord::Migration[5.2]
  def change
    create_table :tipo_servicios do |t|
      t.string :nombre
      t.string :descripcion
      t.decimal :importe, default: 0.0

      t.timestamps
    end
  end
end
