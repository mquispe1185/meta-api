class RenameUrlFotoToUrlVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :comercios, :url_video, :string
  end
end
