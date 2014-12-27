rustc --crate-name cargo --crate-type bin git/cargo/src/bin/cargo.rs -L build --extern log=build/liblog.rlib -lcurl -lgit2 -lminiz
