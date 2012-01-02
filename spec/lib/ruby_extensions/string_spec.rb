require "spec_helper"

describe String do
  context "blank?" do
    it "should be true" do
      "".blank?.should be_true
    end

    it "should be false" do
      "Not blank".blank?.should be_false
    end
  end

end