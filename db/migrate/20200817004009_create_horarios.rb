class CreateHorarios < ActiveRecord::Migration[5.2]
  def change
    create_table :horarios do |t|
      t.integer :dia
      t.time :desde
      t.time :hasta
      t.references :comercio, foreign_key: true

      t.timestamps
    end
  end
end
