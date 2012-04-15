module ProjectGroupsHelper

  # Generate link to a given project's settings
  # @param project [Project]
  # @param label [Symbol]
  # @param tab [String]
  def link_to_project_settings(project, label = :label_settings, tab = "project_groups")

    link_to l(:label_settings), :controller => "projects", :action => "settings", :id => project, :tab => tab

  end

end
