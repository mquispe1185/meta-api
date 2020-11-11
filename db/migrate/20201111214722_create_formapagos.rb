class CreateFormapagos < ActiveRecord::Migration[5.2]
  def change
    create_table :formapagos do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
