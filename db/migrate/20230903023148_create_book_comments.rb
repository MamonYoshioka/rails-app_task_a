class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :book_commet_id

      t.timestamps
    end
  end
end
