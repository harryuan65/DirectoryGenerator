# frozen_string_literal: true

require "thor"

module DirectoryGenerator
  #
  # Command line interface
  #
  class CLI < Thor
    desc "generate <yaml_path> [options]", "Generate file structure based on a yaml file"
    method_option :dry_run, desc: "dry run"
    method_option :root_path, default: "./", desc: "root directory to put generates directories"
    method_option :ext, default: "md", desc: "file extension for each leaf file"
    method_option :template, desc: "template for leaf file"
    method_option :numbered, desc: "add number to directories. e.g. 01_"
    def generate(yaml_path)
      runner = DirectoryGenerator::Runner.new(yaml_path, options)
      runner.generate_directories
    end

    def self.exit_on_failure?
      true
    end
  end
end
