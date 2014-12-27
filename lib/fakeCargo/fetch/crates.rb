module FakeCargo
  class Fetch
    class Crates
      def initialize(git_dir, crates_loc, use_hash)
        @git_dir = git_dir
        @crates_loc = crates_loc
        @use_hash = use_hash
      end
      class Inst
        def initialize(git_dir, crates_loc, env, crate, dep, version)
          @env = env.new_child(dep.name, git_dir + '/' + dep.name)
          if ! File::directory?(@env.path)
            crates_url = "#{crates_loc}/crates/#{dep.name}/#{version}/download"
            curl_line = "curl -o crate.tar.gz -L #{crates_url}"
            extract_dir = dep.name + '-' + version
            puts("Crate #{dep.name} is not available. To make this crate available, please run the following commands:")
            puts(
              "cd #{git_dir} && " +
              "#{curl_line} && " +
              "tar -xzvf crate.tar.gz && " +
              "mv #{extract_dir} #{dep.name}"
            )
            puts("(replace \"#{version}\" with whatever version is most appropriate.)")
          end
        end
        attr_reader :env
      end
      def fetch(env, crate, dep)
        version =
          if @use_hash
            dep.description['version']
          else
            dep.description
          end
        Inst.new(@git_dir, @crates_loc, env, crate, dep, version)
      end
    end
  end
end
