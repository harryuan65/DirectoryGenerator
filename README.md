# Directory Generator

Generate directories from a defined yaml file. Example:

Note: All keys are listed as Array elements.

```yaml
- Basics:
    - Variables:
        - Declaration and Initialization
        - Scope:
            - Global
            - Local
            - Constant and Immutable
        - Type Inference
    - Some File
- Root File
```

Generates:

```
MyRoot
├── Basics
│   ├── Some File.md
│   └── Variables
│       ├── Declaration and Initialization.md
│       ├── Scope
│       │   ├── Constant and Immutable.md
│       │   ├── Global.md
│       │   └── Local.md
│       └── Type Inference.md
└── Root File.md
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'directory_generator', git: "https://github.com/harryuan65/DirectoryGenerator"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ git clone https://github.com/harryuan65/DirectoryGenerator
    $ cd DirectoryGenerator
    $ gem build directory_generator.gemspec
    $ gem install directory_generator-0.1.0.gem

## Usage

```
Usage:
  directory_generator generate <yaml_path> [options]

Options:
  [--dry-run=DRY_RUN]      # dry run
  [--root-path=ROOT_PATH]  # root directory to put generates directories
                           # Default: ./
  [--ext=EXT]              # file extension for each leaf file
                           # Default: md
```

```bash
bundle exec directory_generator generate path_to_yaml_file
bundle exec directory_generator generate ./template.yml --root-path MyRoot --ext js --template ./t.js --numbered
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/directory_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/directory_generator/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the directoryGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/directory_generator/blob/main/CODE_OF_CONDUCT.md).
