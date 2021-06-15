class ChangeHashToSlug < ActiveRecord::Migration[6.1]
  def change
    rename_column :links, :hash, :slug
  end
end
