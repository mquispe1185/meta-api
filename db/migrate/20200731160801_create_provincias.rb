class CreateProvincias < ActiveRecord::Migration[5.2]
  def change
    create_table :provincias do |t|
      t.string :nombre
      t.boolean :activo, default: true

      t.timestamps
    end
  end
end
