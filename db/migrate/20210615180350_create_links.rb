class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :hash
      t.string :url
      t.timestamps
    end

    add_reference :hits, :link, index:true
  end
end
