class DeleteUserAndTaskAssociation < ActiveRecord::Migration
  def change
    remove_index :tasks, :user_id
  end
end
