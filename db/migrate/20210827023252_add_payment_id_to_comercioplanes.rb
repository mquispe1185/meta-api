class AddPaymentIdToComercioplanes < ActiveRecord::Migration[5.2]
  def change
    add_column :comercioplanes, :payment_id, :integer, default: 0
  end
end
