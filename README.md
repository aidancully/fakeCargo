# FakeCargo - A tool for bootstrapping a "cargo" compilation.

Cargo is itself implemented in Cargo, which makes getting an initial
compilation much more difficult than it needs to be. As far as I can
tell, there is nothing Cargo does which requires that it be
implemented in Cargo, and by implementing it in another language, we
can break the circular dependency of Cargo on itself, allowing us to
bootstrap a Cargo compilation.

This is the hacked up script I used to get an initial Cargo
installation in my environment, when I did not have a suitable
cross-compilation host available. It is *not* a suitable replacement
for Cargo, it is only intended to be used for bootstrap, and even in
that limited use, it still requires significant handholding in order
to work correctly. For example:

* It does not understand the target-triples used for declaring
platform-specific dependencies. I worked around this by editing the
relevant Cargo.toml files, and changing the platform-specific
dependency that would have been installed on my platform to be
unconditionally necessary.
* At the time of writing, the ruby `toml` gem does not understand
the TOML `"""` syntax. I worked around this by deleting these
parameters from the relevant TOML files, since these sections were
never used in any directives with which this tool concerned itself.
* This tool does not use the `build.rs` files that are included
in many crates. In some cases, I needed to read these files and
execute the commands suggested in them by hand, in order to satisfy
a dependency.
* This tool does not support running tests, or linking binaries, or
any number of other Cargo features. I built this to support a single
use case (bootstrapping a cargo installation), so I did not add
features I didn't need in trying to reach that goal. This tool got me
to the point that I could build the Cargo library, and the libraries
on which it dependend, in such a way that I could easily run `rustc`
by hand to link the Cargo executable. When that was done, the tool
had served its purpose.

As you see, this is extremely limited. It is not particularly well
structured internally, as I did not know what I was building when I
started, and the scope is limited enough that hacks and experiments
were still understandable to me as I iterated trying to get the
build to work. I publish it for two reasons:

1. In case someone else is ever in the situation I found myself in, of
wanting to get a working rust environment, but working with a
second-class platform, at least they'll have something they can look
at and experiment with.
2. As a proof of concept, that there is no specific reason that the
package manager needs to be implemented in the same language as the
packages being managed.

## Installation

TODO: Write installation instructions.

## Usage

    ruby bin/fakeCargo --help

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fakeCargo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
