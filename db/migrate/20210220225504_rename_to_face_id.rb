class RenameToFaceId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comercios, :twitter, :facebook_id
  end
end
