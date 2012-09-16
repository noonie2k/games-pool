class AddMd5ToGames < ActiveRecord::Migration
  def change
    add_column :games, :md5, :string

    add_index :games, :md5
  end
end
