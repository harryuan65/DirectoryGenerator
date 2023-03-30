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

# :reek:U
def expected_directories(root_path = "./")
  [
    { File.join(root_path, "Basics/Variables/") => "Declaration and Initialization" },
    { File.join(root_path, "Basics/Variables/Scope/") => "Global" },
    { File.join(root_path, "Basics/Variables/Scope/") => "Local" },
    { File.join(root_path, "Basics/Variables/Scope/") => "Constant and Immutable" },
    { File.join(root_path, "Basics/Variables/") => "Type Inference" },
    { File.join(root_path, "Basics/") => "Some File" },
    { root_path => "Root File" }
  ]
end

RSpec.describe DirectoryGenerator::Runner do
  let(:example_ext) { "txt" }
  let(:example_target_root) { "testing123" }

  context "when dry running(default)" do
    subject(:dry_run) do
      DirectoryGenerator::Runner.new(TEST_CASE_PATH,
                                     ext: example_ext,
                                     root_path: example_target_root,
                                     dry_run: true).generate_directories
    end

    let(:expected_list_expanded) do     # Expand ./Basics... to actual paths
      expected_directories(example_target_root).map do |pair|
        path, content = pair.entries.first
        { File.expand_path(path) => content + ".#{example_ext}" }
      end
    end

    it "generates a list of expected directory entries" do
      expect(dry_run).to eq(expected_list_expanded)
    end
  end

  context "when performing" do
    subject(:run) do
      DirectoryGenerator::Runner.new(TEST_CASE_PATH,
                                     ext: example_ext,
                                     root_path: example_target_root,
                                     dry_run: false).generate_directories
    end
    it "generates expected directories" do
      run

      expected_directories(example_target_root).each do |pair|
        path, content = pair.entries.first
        path_to_file = File.expand_path(File.join(path, content + ".#{example_ext}"))
        expect(File.file?(path_to_file)).to eq(true), "expected #{path_to_file} to be a file"
      end
    end
    after { FileUtils.rm_rf(File.expand_path(example_target_root)) }
  end
end
