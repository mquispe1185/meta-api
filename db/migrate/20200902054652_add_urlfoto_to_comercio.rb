class AddUrlfotoToComercio < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :url_foto, :string
  end
end
