class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :name
      t.string :invite_code

      t.timestamps
    end
  end
end
