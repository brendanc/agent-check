class AddHeadersToHit < ActiveRecord::Migration
  def change
    add_column :hits, :all_headers, :text
  end
end
