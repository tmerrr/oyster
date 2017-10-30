require 'oystercard'

describe Oystercard do

  describe "#balance" do
    context "When a new card is intialized" do
      it "has a balance of 0" do
        expect(subject.balance).to eq 0
      end
    end
  end



end
