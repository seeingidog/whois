require "spec_helper"

describe Whois::Answer::Nameserver do

  it "inherits from SuperStruct" do
    klass.ancestors.should include(SuperStruct)
  end


  describe ".new" do
    it "accepts an empty value" do
      lambda do
        i = klass.new
        i.name.should be_nil
      end.should_not raise_error
    end

    it "accepts an empty hash" do
      lambda do
        i = klass.new({})
        i.name.should be_nil
      end.should_not raise_error
    end

    it "initializes a new instance from given params" do
      i = klass.new("ns1.example.com", "127.0.0.1")

      i.name.should == "ns1.example.com"
      i.ipv4.should == "127.0.0.1"
      i.ipv6.should be_nil
    end

    it "initializes a new instance from given hash" do
      i = klass.new(:name => "ns1.example.com", :ipv4 => "127.0.0.1")

      i.name.should == "ns1.example.com"
      i.ipv4.should == "127.0.0.1"
      i.ipv6.should be_nil
    end

    it "initializes a new instance from given block" do
      i = klass.new do |c|
        c.name  = "ns1.example.com"
        c.ipv4  = "127.0.0.1"
      end

      i.name.should == "ns1.example.com"
      i.ipv4.should == "127.0.0.1"
      i.ipv6.should be_nil
    end
  end

end
