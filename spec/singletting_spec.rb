require "spec_helper"

describe :Singlettings do

  describe "class level singletting" do
    before do
      class DevelopmentSample < Singlettings::Base
        source "spec/sample.yml"
        ns :development
      end

      class Sample < Singlettings::Base
        source "spec/sample.yml"
      end
    end
    context "method test" do
      it "one level sample" do
        DevelopmentSample.adapter.should == "mysql2"
        DevelopmentSample.encoding.should == "utf8"
        DevelopmentSample.password.should == nil
      end

      it "multiple level sample" do
        Sample.development.adapter.should == "mysql2"
        Sample.development.encoding.should == "utf8"
        Sample.development.password.should == nil
      end
    end

    context "keyword test" do
      it "one level sample" do
        DevelopmentSample["adapter"].should == "mysql2"
        DevelopmentSample["encoding"].should == "utf8"
        DevelopmentSample["password"].should == nil
      end

      it "multiple level sample" do
        Sample[:development][:adapter].should == "mysql2"
        Sample[:development][:encoding].should == "utf8"
        Sample[:development][:password].should == nil
      end
    end

    context "response to method" do
      it "one level sample" do
        [:adapter, :encoding, :password].each do |method|
          DevelopmentSample.should respond_to(method)
        end
      end

      it "multiple level sample" do
        [:adapter, :encoding, :password].each do |method|
          Sample.development.should respond_to(method)
        end
      end
    end
  end

  describe "instance level singlettings" do
    before do
      @development_settings = Singlettings::Base.new "spec/sample.yml", :development
      @settings = Singlettings::Base.new "spec/sample.yml"
    end

    context "method test" do
      it "one level sample" do
        @development_settings.adapter.should == "mysql2"
        @development_settings.encoding.should == "utf8"
        @development_settings.password.should == nil
      end

      it "multiple level sample" do
        @settings.development.adapter.should == "mysql2"
        @settings.development.encoding.should == "utf8"
        @settings.development.password.should == nil
      end
    end

    context "keyword test" do
      it "one level sample" do
        @development_settings["adapter"].should == "mysql2"
        @development_settings["encoding"].should == "utf8"
        @development_settings["password"].should == nil
      end

      it "multiple level sample" do
        @settings[:development][:adapter].should == "mysql2"
        @settings[:development][:encoding].should == "utf8"
        @settings[:development][:password].should == nil
      end
    end

    context "response to method" do
      it "one level sample" do
        [:adapter, :encoding, :password].each do |method|
          @development_settings.should respond_to(method)
        end
      end

      it "multiple level sample" do
        [:adapter, :encoding, :password].each do |method|
          @settings.development.should respond_to(method)
        end
      end
    end
  end
end