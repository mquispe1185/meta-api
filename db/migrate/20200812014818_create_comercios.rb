class CreateComercios < ActiveRecord::Migration[5.2]
  def change
    create_table :comercios do |t|
      t.string :nombre
      t.string :domicilio
      t.string :telefono
      t.string :celular
      t.string :web
      t.time :horario_desde
      t.time :horario_hasta
      t.time :horario_desde2
      t.time :horario_hasta2
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :latitud
      t.string :longitud
      t.string :email
      t.references :rubro, foreign_key: true
      t.references :provincia, foreign_key: true
      t.references :departamento, foreign_key: true
      t.references :localidad, foreign_key: true
      t.string :descripcion
      t.references :usuario, foreign_key: true
      t.boolean :entrega, default: false
      t.boolean :activo, default: true

      t.timestamps
    end
  end
end
