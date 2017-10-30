require 'station'

describe Station do
  subject(:station) { described_class.new("Aldgate", 1) }

  describe "@Name" do
    it "returns station name" do
      expect(station.name).to eq "Aldgate"
    end
  end


  describe "@Zone" do
    it "it returns station zone" do
      expect(station.zone).to eq 1
    end
  end
end
