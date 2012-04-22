# -*- encoding : utf-8 -*-
class AddProjectGroupProjectIdIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :project_group_project_id
  end

  def self.down
    remove_index :users, :column => :project_group_project_id
  end
end
