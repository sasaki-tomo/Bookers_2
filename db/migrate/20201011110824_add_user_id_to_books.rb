class AddUserIdToBooks < ActiveRecord::Migration[5.2]
  def up
    add_column :books, :user_id, :integer
  end
end
