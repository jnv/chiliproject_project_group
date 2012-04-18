# Project Group plugin for ChiliProject

[![Build Status](https://secure.travis-ci.org/jnv/chiliproject_project_group.png?branch=master)](http://travis-ci.org/jnv/chiliproject_project_group)

Provides per-project groups for ChiliProject. Groups can be created and managed by roles with "Manage project groups" permission and administrators. Groups are added to all subprojects but cannot be managed from there.

## Installation

1. Follow the instructions at https://www.chiliproject.org/projects/chiliproject/wiki/Plugin_Install
2. New tab "Groups" will appear in Project Settings, here you can create new group for this project
3. You can add "Manage project groups" permission to roles, the permission is available in Permissions report

## Compatibility

Plugin was tested with ChiliProject 3.1.0 and Ruby 1.9.3.

## Development and testing

Patches, pull requests and forks are welcome, but if possible, provide proper test coverage.

Test suite uses [Shoulda](https://github.com/thoughtbot/shoulda/tree/v2.10.3) and [Object Daddy](https://github.com/edavis10/object_daddy).

To run tests, follow [Redmine's instructions](http://www.redmine.org/projects/redmine/wiki/Plugin_Tutorial#Initialize-Test-DB).

Due to [Engines compatibility bug](https://www.chiliproject.org/issues/944) the test suite won't work under Ruby 1.9 with standard ChiliProject distribution. You can replace ChiliProject's engines with [fixed version](https://github.com/jnv/engines).

You can also use [Travis-CI](http://travis-ci.org/) integration based on the [chiliproject_test_plugin](https://github.com/jnv/chiliproject_test_plugin).

## License

This plugin is licensed under the GNU GPL v2. See COPYRIGHT.txt and LICENSE.txt for details.
