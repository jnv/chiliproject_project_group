# -*- encoding : utf-8 -*-
module ProjectGroupPlugin
  module GroupsControllerPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :index, :project_groups
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      # XXX Breaks method chain
      def index_with_project_groups
        #index_without_project_groups
        @groups = Group.global_only.find(:all, :order => 'lastname')

        respond_to do |format|
          format.html # index.html.erb
          format.xml { render :xml => @groups }
        end
      end
    end

  end
end
