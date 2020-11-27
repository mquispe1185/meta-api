class AddUrlToPromociones < ActiveRecord::Migration[5.2]
  def change
    add_column :promociones, :url, :string
  end
end
