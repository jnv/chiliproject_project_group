# -*- encoding : utf-8 -*-
module ProjectGroupPlugin

  # Replaces standard uniqueness validation for lastname
  # with validation scoped by project_group_project_id
  module GroupPatch

    def self.included(base)
      base.class_eval do
        unloadable

        # Kudos to Lawrence McAlpin
        # http://www.lmcalpin.com/post/5219540409/overriding-rails-validations-metaprogramatically
        @validate_callbacks.reject! do |c|
          begin
            if Proc === c.method && eval("attrs", c.method.binding).first == :lastname && c.options[:case_sensitive] == false
              true
            end
          rescue
            false
          end
        end

        validates_uniqueness_of :lastname, :case_sensitive => false, :scope => :project_group_project_id
      end
    end
  end
end
