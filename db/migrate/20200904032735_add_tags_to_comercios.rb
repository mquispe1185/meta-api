class AddTagsToComercios < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :tags, :string
  end
end
