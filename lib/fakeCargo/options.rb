require 'optparse'

module FakeCargo
  class Options
    def initialize(output_dir)
      @output_dir = output_dir
    end
    attr_reader :output_dir

    def self.from_cmd_line(argv_)
      output_dir = nil

      oparser = OptionParser.new do |opts|
        opts.on(
          '-o', '--output-dir OUTPUTDIR',
          "Build libraries into OUTPUTDIR"
        ) do |output_dir_|
          output_dir = output_dir_
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
      return [ self.new(output_dir), argv ]
    end
  end
end
