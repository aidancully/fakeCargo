module FakeCargo
  class Fetch
    class Git
      def initialize(git_dir)
        @git_dir = git_dir
      end
      class Inst
        def initialize(git_dir, env, crate, dep)
          @env = env.new_child(
            dep.name, git_dir + '/' + File.basename(dep.description['git'])
          )
          if ! File::directory?(@env.path)
            system("cd #{git_dir} && git clone #{dep.description['git']}")
          end
        end
        attr_reader :env
      end
      def fetch(env, crate, dependency)
        Inst.new(@git_dir, env, crate, dependency)
      end
    end
  end
end
