# frozen_string_literal: true

module DirectoryGenerator
  #
  # Load entries from yaml and generate a list of paths
  #
  class Runner
    # @param [String] yaml_path Path to yaml file
    # @param [Hash] options
    # @option options [TrueClass, FalseClass] dry_run, default: nil
    # @option options [String] root_path, default: "./"
    # @option options [String] ext: extension, ex: md
    #
    def initialize(yaml_path, options)
      @dry_run = options[:dry_run]
      @root_path = options[:root_path] || "./"
      @extension = ".#{options[:ext] || "md"}"
      @template_path = options[:template]
      @numbered = options[:numbered]
      @root_dir_hash = Psych.safe_load(File.read(yaml_path))
      @paths = []
    end

    # @param [Hash] dir: A hash representing a dir structure, loaded from Psych.load
    def generate_directories
      @root_path = File.expand_path(@root_path)
      dfs(@root_path, @root_dir_hash)

      if @dry_run
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

      dir.each_with_index do |content, i| # Basics: [{A => ["b" ,"c"]}, "Some File"]
        case content
        when Hash
          content.each_with_index do |(sub_dir_name, sub_dir_contents), j|
            new_sub_dir_name = numbered(sub_dir_name, j)
            dfs(File.join(path, new_sub_dir_name), sub_dir_contents)
          end
        when String # Handle root case
          content_name = numbered(content, i)
          @paths << { path => trim(content_name) + @extension }
        end
      end
    end

    def numbered(name, index)
      @numbered ? "#{(index + 1).to_s.rjust(2, "0")}_#{name}" : name
    end

    def generate_files
      @paths.each do |pair|
        folder_name, file_name = pair.entries.first
        FileUtils.mkdir_p(folder_name) unless File.directory?(folder_name)

        path = File.join(folder_name, file_name)
        if !File.file?(path)
          File.write(path, template)
        else
          warn "File #{path} already exists"
        end
      end
    end

    def trim(filename)
      filename.tr("/", "-")
    end

    def template
      @template ||= if @template_path
                      File.read(File.expand_path(@template_path))
                    else
                      ""
                    end
    end
  end
end
