class AddEsPaginaToComercio < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :es_fanpage, :boolean, default: false
  end
end
