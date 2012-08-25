class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.references :platform
      t.string :img_thumb_url
      t.string :img_tiny_url
      t.references :owner

      t.timestamps
    end
    add_index :games, :platform_id
    add_index :games, :owner_id
  end
end
