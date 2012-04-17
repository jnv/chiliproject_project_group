# -*- encoding : utf-8 -*-
class ProjectGroupScope < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :project_group

end
