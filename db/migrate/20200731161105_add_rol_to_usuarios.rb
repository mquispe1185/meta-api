class AddRolToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_reference :usuarios, :rol, foreign_key: true
    add_reference :usuarios, :provincia, foreign_key: true
    add_reference :usuarios, :departamento, foreign_key: true
    add_reference :usuarios, :localidad, foreign_key: true
  end
end
