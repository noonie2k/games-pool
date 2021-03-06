class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :pool
      t.references :user

      t.timestamps
    end
    add_index :memberships, :pool_id
    add_index :memberships, :user_id
  end
end
