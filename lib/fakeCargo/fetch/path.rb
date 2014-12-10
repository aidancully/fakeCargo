module FakeCargo
  class Fetch
    class Path
      def initialize(env, crate, dep)
        @env = env.new_child(dep.name, env.path + '/' + dep.description['path'])
      end
      def self.fetch(env, crate, dep)
        self.new(env, crate, dep)
      end
      attr_reader :env
    end
  end
end
