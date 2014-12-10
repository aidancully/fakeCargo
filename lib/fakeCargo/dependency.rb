module FakeCargo
  class Dependency
    def initialize(name, description)
      @name = name
      @description = description
    end
    attr_reader :name
    attr_reader :description
  end
end
