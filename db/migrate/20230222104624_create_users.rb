class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :photo
      t.date :updatedAt
      t.date :createdAt
      t.integer :postsCounter
      s

      t.timestamps
    end
  end
end
