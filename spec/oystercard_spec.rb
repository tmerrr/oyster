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

  describe '#deduct' do
    context 'when calling deduct(10) on a card with 50 as value' do
      it 'returns balance as 40' do
        card = Oystercard.new(50)
        expect { card.deduct(10) }.to change { card.balance }.by(-10)
      end
    end
  end

end
