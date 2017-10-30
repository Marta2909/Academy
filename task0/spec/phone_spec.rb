require "phone"

describe PhoneRunner do
  it "should change letters to number" do
    expect(PhoneRunner.new.run(["FLOWERS"])).to eq "3569377"
  end

  it "should write proper phone_number" do
    expect(PhoneRunner.new.run(["1-800-FLOWERS"])).to eq "1-800-3569377"
    expect(PhoneRunner.new.run(["1-800-800"])).to eq "1-800-800"
  end

  it "should inform that the input is mandatory" do
    expect(PhoneRunner.new.run([])).to eq "Proper usage: \nphone.rb number"
  end
end
