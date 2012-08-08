# Project Group plugin for ChiliProject [![Build Status](https://secure.travis-ci.org/jnv/chiliproject_project_group.png?branch=master)](http://travis-ci.org/jnv/chiliproject_project_group)

Provides per-project groups for ChiliProject. Groups can be created and managed by roles with "Manage project groups" permission and administrators. Groups are added to all subprojects but cannot be managed from there.

## Installation

1. Follow the instructions at https://www.chiliproject.org/projects/chiliproject/wiki/Plugin_Install
2. New tab "Groups" will appear in Project Settings, here you can create new group for this project
3. You can add "Manage project groups" permission to roles, the permission is available in Permissions report

## Dependencies

Plugin depends on the [MembersView](https://github.com/jnv/chiliproject_members_view) gem. It will be picked by `bundle install`.

## Compatibility

Plugin was tested with ChiliProject 3.1.0 and Ruby 1.9.3.

## Development and testing

Patches, pull requests and forks are welcome, but if possible, provide proper test coverage.

You can also use [Travis-CI](http://travis-ci.org/) integration based on the [chiliproject_test_plugin](https://github.com/jnv/chiliproject_test_plugin).

For running tests, see also [Redmine's instructions](http://www.redmine.org/projects/redmine/wiki/Plugin_Tutorial#Running-test).

Setup and migrate your test database:

```
bundle exec rake db:drop db:create db:migrate redmine:load_default_data db:migrate:plugins RAILS_ENV=test
```

To run tests, execute the following task from main ChiliProject's directory:

```
bundle exec rake test:engines:all PLUGIN=chiliproject_project_group
```

You can also execute individual test files, however you need to run this rake task before execution:

```
bundle exec rake test:plugins:setup_plugin_fixtures
```

## License

This plugin is licensed under the GNU GPL v2. See COPYRIGHT.txt and LICENSE.txt for details.
