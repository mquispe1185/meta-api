class CreatePromociones < ActiveRecord::Migration[5.2]
  def change
    create_table :promociones do |t|
      t.references :comercio, foreign_key: true
      t.references :usuario, foreign_key: true
      t.date :desde
      t.date :hasta
      t.string :titulo
      t.string :descripcion
      t.integer :duracion
      t.boolean :vencido
      t.integer :prioridad
      t.integer :estado
      t.boolean :habilitado
      
      t.timestamps
    end
  end
end
