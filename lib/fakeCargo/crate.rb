require 'pp'

module FakeCargo
  class Crate
    def initialize(filename, toml)
      @filename = filename
      lib = toml['lib'] || Hash.new
      package = toml['package'] || Hash.new
      @name = lib['name'] || package['name']
      @path = lib['path'] || 'src/lib.rs'
      dep_descriptions = toml['dependencies'] || []
      @dependencies = dep_descriptions.map do |name, description|
        Dependency.new(name, description)
      end
    end
    attr_reader :filename
    attr_reader :name
    attr_reader :path
    attr_reader :dependencies
    def cmdline
      args = []
      args += [ '--crate-name', self.name ] if self.name
      args += [ File.join(File.dirname(@filename), self.path) ]
      args
    end
  end
end
