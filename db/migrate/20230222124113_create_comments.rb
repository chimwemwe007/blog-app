class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.date :createdAt
      t.string :updatedAt
      

      t.timestamps
    end
  end
end
