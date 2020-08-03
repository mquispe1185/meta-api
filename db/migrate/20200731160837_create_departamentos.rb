class CreateDepartamentos < ActiveRecord::Migration[5.2]
  def change
    create_table :departamentos do |t|
      t.string :nombre
      t.references :provincia, foreign_key: true
      t.boolean :activo, default: true

      t.timestamps
    end
  end
end
