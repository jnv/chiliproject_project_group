# -*- encoding : utf-8 -*-
module ProjectGroupsHelper

  # Generate link to a given project's settings
  # @param project [Project]
  # @param label [Symbol]
  # @param tab [String]
  def link_to_project_settings(project, label = :label_settings, tab = "project_groups")
    link_to l(:label_settings), :controller => "projects", :action => "settings", :id => project, :tab => tab
  end

  # A fancy wrapper for permission check
  # @param project [Project]
  # @param group [ProjectGroup]
  # @return [Bool]
  def can_manage_group?(project, group)
    group.is_child_of?(project)
  end

  def project_group_settings_tabs
    tabs = [{:name => 'users', :partial => 'project_groups/users', :label => :label_user_plural},
            {:name => 'general', :partial => 'project_groups/general', :label => :label_general}
    ]
  end

end
