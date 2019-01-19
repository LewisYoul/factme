class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body_one
      t.text :body_two
      t.string :gist

      t.timestamps
    end
  end
end
