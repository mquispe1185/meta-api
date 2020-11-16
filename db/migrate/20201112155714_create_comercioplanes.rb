class CreateComercioplanes < ActiveRecord::Migration[5.2]
  def change
    create_table :comercioplanes do |t|
      t.references :comercio, foreign_key: true
      t.references :tipo_servicio, foreign_key: true
      t.references :formapago, foreign_key: true
      t.integer :estado, default: 0
      t.date :desde
      t.date :hasta
      t.decimal :importe

      t.timestamps
    end
  end
end
