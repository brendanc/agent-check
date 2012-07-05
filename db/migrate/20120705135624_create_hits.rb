class CreateHits < ActiveRecord::Migration
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
