class AddFormapagoToPromociones < ActiveRecord::Migration[5.2]
  def change
    add_reference :promociones, :formapago, foreign_key: true
  end
end
