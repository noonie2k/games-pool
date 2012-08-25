class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :color_code

      t.timestamps
    end
  end
end
