require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new(50) }

  describe "#balance" do
    context "When a new card is intialized" do
      it "has a balance of 0" do
        expect(subject.balance).to eq Oystercard::MIN_FARE
      end
    end
  end

  describe '#top_up' do
    it { expect { subject.top_up(10) }.to change { subject.balance }.by(10) }
    it { expect { subject.top_up(Oystercard::MAX_VALUE + 1) }.to raise_error "Cannot exceed max balance of #{Oystercard::MAX_VALUE}" }
  end

  describe '#touch_in' do
    context 'when card is being used to travel' do
      it 'should return true for touch in' do
        expect(card.touch_in).to be true
      end
    end

    context "when you don't have enough balance for one journey" do
      it "returns an Error" do
        expect { subject.touch_in }.to raise_error 'Insufficient Funds'
      end
    end
  end

  describe '#in_journey?' do
    context 'when card is in use' do
      it "returns true" do
        card.touch_in
        expect(card.in_journey?).to be true
      end
    end
  end

  describe '#touch_out' do
    context 'when user is not traveling' do
      it "should change journery status" do
        card.touch_in
        expect { card.touch_out }.to change { card.in_journey? }
      end
    end

    context 'when user touches out' do
      it "should reduce by minimum fare" do
        card.touch_out
        expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MIN_FARE)
      end
    end
  end

end
