require 'optparse'

module FakeCargo
  class Options
    def initialize(output_dir, git_dir, crates_dir, command)
      @output_dir = output_dir
      @git_dir = git_dir
      @crates_dir = crates_dir
      @command = command
    end
    attr_reader :output_dir
    attr_reader :git_dir
    attr_reader :crates_dir
    attr_reader :command

    def self.from_cmd_line(argv_)
      output_dir = nil
      git_dir = nil
      command = nil
      crates_dir = 'https://crates.io/api/v1'

      oparser = OptionParser.new do |opts|
        opts.on(
          '-o', '--output-dir OUTPUTDIR',
          "Build libraries into OUTPUTDIR"
        ) do |output_dir_|
          output_dir = output_dir_
        end

        opts.on(
          '-g', '--git-dir GITDIR',
          "Build libraries into GITDIR"
        ) do |git_dir_|
          git_dir = git_dir_
        end

        opts.on(
          '-C', '--crates-dir CRATESDIR',
          "Fetch crates.io indices from CRATESDIR (default #{crates_dir})"
        ) do |crates_dir_|
          crates_dir = crates_dir_
        end

        opts.on(
          '-c', '--command COMMAND',
          "Run command COMMAND"
        ) do |command_|
          command = command_
        end

        opts.on_tail('-h', '--help', "Show this message") do
          puts(opts)
          exit
        end
        opts.on_tail('-V', '--version', "Show version") do
          puts(FakeCargo::VERSION)
          exit
        end
      end

      argv = argv_.dup
      oparser.parse!(argv)
      return [ self.new(output_dir, git_dir, crates_dir, command), argv ]
    end
  end
end
