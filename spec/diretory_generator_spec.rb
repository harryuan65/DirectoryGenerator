# frozen_string_literal: true

RSpec.describe DirectoryGenerator do
  let(:example_ext) { "txt" }

  it "has a version number" do
    expect(DirectoryGenerator::VERSION).not_to be nil
  end
end
