class CreateLocalidades < ActiveRecord::Migration[5.2]
  def change
    create_table :localidades do |t|
      t.string :nombre
      t.references :departamento, foreign_key: true
      t.references :provincia, foreign_key: true
      t.boolean :activo, default: true

      t.timestamps
    end
  end
end
