# frozen_string_literal: true

require_relative "directory_generator/version"
require_relative "directory_generator/runner"
require_relative "directory_generator/cli"
require "psych"
require "fileutils"

#                   - Basics                      - Root File
#               /                \
#             Variables           Some File
#             /    |   \
#         Decla.. Scope Type...
#                 / | \
#         Global Local Const..
#
module DirectoryGenerator
end
