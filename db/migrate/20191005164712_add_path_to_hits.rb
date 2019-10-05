class AddPathToHits < ActiveRecord::Migration[5.2]
  def change
    add_column :hits, :path, :string
  end
end
