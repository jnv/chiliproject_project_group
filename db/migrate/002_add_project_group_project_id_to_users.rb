# -*- encoding : utf-8 -*-
class AddProjectGroupProjectIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :project_group_project_id, :integer
    #add_index
  end

  def self.down
    remove_column :users, :project_group_project_id
  end
end
