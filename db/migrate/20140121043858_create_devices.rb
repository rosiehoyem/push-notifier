class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.text :token
      t.text :platform
      t.integer :user_id

      t.timestamps
    end
  end
end
