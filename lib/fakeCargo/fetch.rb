require "fakeCargo/fetch/git"
require "fakeCargo/fetch/path"
require "fakeCargo/fetch/crates"

module FakeCargo
  class Fetch
    def initialize(git_dir, crates_repo)
      @default_mech = FakeCargo::Fetch::Crates.new(git_dir, crates_repo, false)
      @mechanisms = [
        [ "git", FakeCargo::Fetch::Git.new(git_dir) ],
        [ "path", FakeCargo::Fetch::Path ],
        [ "version", FakeCargo::Fetch::Crates.new(git_dir, crates_repo, true) ],
      ]
    end

    def find_mechanism(description)
      @mechanisms.each do |mech|
        if description.has_key?(mech[0])
          return mech[1]
        end
      end
    end

    def fetch(env, crate, dependency)
      mech = 
        if dependency.description.is_a?(String)
          @default_mech
        else
          self.find_mechanism(dependency.description)
        end
      if ! mech
        raise Exception, "Could not find mechanism for #{dependency.description}"
      end
      mech.fetch(env, crate, dependency)
    end
  end
end
