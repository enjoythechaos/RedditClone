class RemoveUniqueUserId < ActiveRecord::Migration
  def change
    remove_index :subs, :user_id

    add_index :subs, :user_id
  end
end
