# frozen_string_literal: true

module DirectoryGenerator
  #
  # Load entries from yaml and generate a list of paths
  #
  class Runner
    def initialize(yaml_path, extension: "md")
      @root = Psych.safe_load(File.read(yaml_path))
      @paths = []
      @extension = ".#{extension}"
    end

    # @param [Hash] dir: A hash representing a dir structure, loaded from Psych.load
    def generate_directories(root_path: "./", dry_run: true)
      root_path = File.expand_path(root_path)
      dfs(root_path, @root)

      if dry_run
        warn "Dry running: #{@paths}"
        @paths
      else
        generate_files
      end
    end

    private

    # :reek:U
    # Recursively add path to @paths
    # @param [Hash|String] dir <description>
    # @param [<Type>] path Contains / at the end
    #
    # @return [<Type>] <description>
    #
    def dfs(path, dir)
      if dir.is_a?(String) # just a file name
        @paths << { path => trim(dir) + @extension } # folder_name => file_name
        return
      end

      dir.each do |content| # Basics: [{A => ["b" ,"c"]}, "Some File"]
        case content
        when Hash
          content.each do |sub_dir_name, sub_dir_contents|
            dfs(File.join(path, sub_dir_name), sub_dir_contents)
          end
        when String # Handle root case
          @paths << { path => trim(content) + @extension }
        end
      end
    end

    def generate_files
      @paths.each do |pair|
        folder_name, file_name = pair.entries.first
        FileUtils.mkdir_p(folder_name) unless File.directory?(folder_name)

        path = File.join(folder_name, file_name)
        if !File.file?(path)
          File.open(path, "w")
        else
          warn "File #{path} already exists"
        end
      end
    end

    def trim(filename)
      filename.tr("/", "-")
    end
  end
end
