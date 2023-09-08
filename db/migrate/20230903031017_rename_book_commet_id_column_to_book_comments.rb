class RenameBookCommetIdColumnToBookComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :book_comments, :book_commet_id, :book_id
  end
end
