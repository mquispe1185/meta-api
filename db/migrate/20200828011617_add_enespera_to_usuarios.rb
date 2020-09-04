class AddEnesperaToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :en_espera, :boolean, default: false
  end
end
