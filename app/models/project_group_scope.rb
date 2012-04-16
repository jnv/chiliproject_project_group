# -*- encoding : utf-8 -*-
class ProjectGroupScope < ActiveRecord::Base
  unloadable

  belongs_to :project
  belongs_to :project_group

  attr_protected :manageable

  default_scope :include => :project_group

  delegate :lastname, :users, :to => :project_group

  def manageable?
    manageable
  end
end
