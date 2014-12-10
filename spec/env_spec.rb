require 'fakeCargo'

RSpec.describe FakeCargo::Env do
  describe "#dir" do
    it "represents the linear dependency hierarchy" do
      env = FakeCargo::Env.new('.', '')
      foo = env.new_child('foo', 'bar')
      expect(foo.dir).to eql('./foo')
      expect(foo.path).to eql('bar')
      baz = foo.new_child('baz', 'quux')
      expect(baz.dir).to eql('./foo/baz')
      expect(baz.path).to eql('quux')
    end
    it "raises an exception when a duplicate path is detected" do
      env = FakeCargo::Env.new('', '')
      foo = env.new_child('foo', 'bar')
      expect { foo.new_child('baz', 'bar') }.to raise_error
    end
    it "does not raise an exception when a diamond inheritance path is detected" do
      env = FakeCargo::Env.new('', '')
      foo = env.new_child('foo', 'bar')
      foo_baz = foo.new_child('baz', 'quux')
      baz = env.new_child('baz', 'quux')
    end
  end
end
