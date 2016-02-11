class AddTeamAndUserToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :team, index: true
    add_reference :tasks, :user, index: true
  end
end
