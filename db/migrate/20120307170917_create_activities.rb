class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :summary
      t.text :description
      t.integer :organization_id

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
