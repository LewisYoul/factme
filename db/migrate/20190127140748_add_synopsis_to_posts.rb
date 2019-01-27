class AddSynopsisToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :synopsis, :string
  end
end
