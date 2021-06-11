class AddHeadersToHit < ActiveRecord::Migration[5.2]
  def change
    add_column :hits, :all_headers, :text
  end
end
