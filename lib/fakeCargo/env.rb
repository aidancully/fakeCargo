module FakeCargo
  # define build directory for direct dependencies
  class Env
    def initialize(name, path, parent = nil)
      @name = name
      @parent = parent
      @children = Array.new
      @dir = 
        if parent
          "#{parent.dir}/#{name}"
        else
          name
        end
      @path = path
    end
    attr_reader :name
    attr_reader :dir
    attr_reader :path
    attr_reader :children
    
    def new_child(name, path)
      self.check_no_cycle(path)
      child = self.class.new(name, path, self)
      @children << child
      child
    end
    def check_no_cycle(path)
      if(@path == path)
        raise Exception, "#{path} encountered before at #{self.dir}"
      elsif(@parent)
        @parent.check_no_cycle(path)
      end
    end
  end
end
