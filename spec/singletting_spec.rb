require "spec_helper"

describe :Singletting do

  describe "class level singletting" do
    before do
      class DevelopmentSample < Singletting::Base
        source "spec/sample.yml"
        ns :development
      end

      class Sample < Singletting::Base
        source "spec/sample.yml"
      end
    end
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

  describe "instance level singletting" do
    before do
      @development_settings = Singletting::Base.new "spec/sample.yml", :development
      @settings = Singletting::Base.new "spec/sample.yml"
    end
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
end