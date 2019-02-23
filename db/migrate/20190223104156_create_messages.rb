class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :room_id
      t.integer :article_id
      t.integer :story_id
      t.text :comment
      t.boolean :checked

      t.timestamps
    end
  end
end
