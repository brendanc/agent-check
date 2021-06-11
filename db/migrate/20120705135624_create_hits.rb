class CreateHits < ActiveRecord::Migration[5.2]
  def change
    create_table :hits do |t|
      t.string :agent
      t.string :ip
      t.string :referrer
      t.string :code

      t.timestamps
    end
  end
end
