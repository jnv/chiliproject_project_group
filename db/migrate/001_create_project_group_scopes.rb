class CreateProjectGroupScopes < ActiveRecord::Migration
  def self.up
    create_table :project_group_scopes, :id => false do |t|
      t.column :project_id, :integer, :null => false
      t.column :project_group_id, :integer, :null => false
      t.column :manageable, :boolean, :default => false, :null => false
    end
    add_index :project_group_scopes, [:project_id, :project_group_id], :unique => true
  end

  def self.down
    #TODO: clean-up all ProjectGroups
    drop_table :project_group_scopes
  end
end
