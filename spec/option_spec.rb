require 'fakeCargo'

RSpec.describe FakeCargo::Options do
  describe "#output_dir" do
    it "basically parses command-line arguments correctly" do
      orig_cmdline = [ '--output-dir', 'foo', 'bar' ]
      cmdline_copy = orig_cmdline.clone
      (o, cmdline) = *FakeCargo::Options.from_cmd_line(orig_cmdline)
      expect(o.output_dir).to eql('foo')
      expect(cmdline).to eql([ 'bar' ])
      expect(orig_cmdline).to eql(cmdline_copy)
    end
  end
end
