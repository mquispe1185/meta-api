class CreateReferencias < ActiveRecord::Migration[5.2]
  def change
    create_table :referencias do |t|
      t.string :cuerpo
      t.references :usuario, foreign_key: true
      t.references :comercio, foreign_key: true
      t.integer :puntaje
      t.boolean :activo, default: true

      t.timestamps
    end
  end
end
