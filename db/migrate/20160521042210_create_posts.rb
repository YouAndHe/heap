class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.boolean :shared
      t.boolean :sent
      t.integer :match_id #보내는 사람Email, 받는 사람Email 저장한 키값 : match.id
      t.integer :user_id  #보내는 사람 id

      t.timestamps null: false
    end
  end
end
