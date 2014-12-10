require "fakeCargo/fetch/git"
require "fakeCargo/fetch/path"

module FakeCargo
  class Fetch
    def initialize(git_dir)
      @mechanisms = [
        [ "git", FakeCargo::Fetch::Git.new(git_dir) ],
        [ "path", FakeCargo::Fetch::Path ],
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
      mech = self.find_mechanism(dependency.description)
      if ! mech
        raise Exception, "Could not find mechanism for #{dependency.description}"
      end
      mech.fetch(env, crate, dependency)
    end
  end
end
