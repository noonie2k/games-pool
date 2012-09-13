class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :user
      t.references :game
      t.integer :status

      t.timestamps
    end
    add_index :loans, :user_id
    add_index :loans, :game_id
    add_index :loans, :status
  end
end
