# frozen_string_literal: true

require "psych"
TEST_CASE_PATH = "spec/fixture/files/simple.yml"
#                   - Basics                      - Root File
#               /                \
#             Variables           Some File
#             /    |   \
#         Decla.. Scope Type...
#                 / | \
#         Global Local Const..
#

EXPECTED = [{ "./Basics/Variables/" => "Declaration and Initialization" },
            { "./Basics/Variables/Scope/" => "Global" },
            { "./Basics/Variables/Scope/" => "Local" },
            { "./Basics/Variables/Scope/" => "Constant and Immutable" },
            { "./Basics/Variables/" => "Type Inference" },
            { "./Basics/" => "Some File" },
            { "./" => "Root File" }].freeze

RSpec.describe DirectoryGenerator::Runner do
  let(:example_ext) { "txt" }

  subject(:given_valid_yaml) { DirectoryGenerator::Runner.new(TEST_CASE_PATH, extension: example_ext) }
  context "when dry running(default)" do
    it "generates a list of expected directory entries" do
      # Expand ./Basics... to actual paths
      expected_list_expanded = EXPECTED.map do |pair|
        path, content = pair.entries.first
        { File.expand_path(path) => content + ".#{example_ext}" }
      end

      expect(given_valid_yaml.generate_directories).to eq(expected_list_expanded)
    end
  end

  context "when performing" do
    let(:example_target_root) { "testing123" }
    it "generates expected directories" do
      given_valid_yaml.generate_directories(root_path: example_target_root, dry_run: false)

      EXPECTED.each do |pair|
        path, content = pair.entries.first
        path_to_file = File.expand_path(File.join(example_target_root, path, content + ".#{example_ext}"))
        expect(File.file?(path_to_file)).to eq(true), "expected #{path_to_file} to be a file"
      end
    end
    after { FileUtils.rm_rf(File.expand_path(example_target_root)) }
  end
end
