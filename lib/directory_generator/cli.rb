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
    def generate(yaml_path)
      root_path = options[:root_path] || "./"
      extension = options[:ext] || "md"
      runner = DirectoryGenerator::Runner.new(yaml_path, extension: extension)
      runner.generate_directories(root_path: root_path, dry_run: options[:dry_run])
    end

    def self.exit_on_failure?
      true
    end
  end
end
