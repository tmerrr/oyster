require 'oystercard'

describe Oystercard do

  describe "#balance" do
    context "When a new card is intialized" do
      it "has a balance of 0" do
        expect(subject.balance).to eq 0
      end
    end
  end

  describe '#top_up' do
    it { expect { subject.top_up(Oystercard::MAX_VALUE) }.to change { subject.balance }.by(Oystercard::MAX_VALUE) }

    it { expect { subject.top_up(Oystercard::MAX_VALUE + 1) }.to raise_error "Cannot exceed max balance of #{Oystercard::MAX_VALUE}" }
  end



end
