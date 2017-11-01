require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new(50) }
  let(:aldgate) { double(:station, :name => 'Aldgate', :zone => 3) }

  describe "#balance" do
    context "When a new card is intialized" do
      it "has a balance of 0" do
        expect(subject.balance).to eq Oystercard::MIN_FARE
      end
    end
  end

  describe '#top_up' do
    it { expect { subject.top_up(10) }.to change { subject.balance }.by(10) }
    it { expect { subject.top_up(Oystercard::MAX_VALUE + 1) }.to raise_error "Max Balance of #{Oystercard::MAX_VALUE}" }
  end

  describe '#touch_in' do
    context 'when card is being used to travel' do
      it 'should return true for touch in' do
        card.touch_in(aldgate)
        expect(card.in_journey?).to be true
      end
    end

    context "when you don't have enough balance for one journey" do
      it "returns an Error" do
        card_with_no_funds = Oystercard.new(0)
        expect { card_with_no_funds.touch_in(aldgate) }.to raise_error 'Insufficient Funds'
      end
    end

    context 'when touching in at Aldgate' do
      it 'changes start point on card' do
        expect { card.touch_in(aldgate) }.to change { card.my_start_point }
        expect(card.my_start_point).to eq({ station: aldgate.name, zone: aldgate.zone })
      end
    end
  end

  describe '#in_journey?' do
    context 'when card is in use' do
      it "returns true" do
        card.touch_in(aldgate)
        expect(card.in_journey?).to be true
      end
    end
  end

  describe '#touch_out' do
    context 'when user is not traveling' do
      it "should change journery status" do
        card.touch_in(aldgate)
        expect { card.touch_out(aldgate) }.to change { card.in_journey? }
      end
    end

    context 'when user touches out' do
      it "should reduce by minimum fare" do
        card.touch_in(aldgate)
        expect { card.touch_out(aldgate) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
      end
    end
  end

  describe "@travel_history" do
    context 'card has an empty history' do
      it "should return an empty array" do
        expect(card.travel_history).to eq []
      end
    end

    context "card should return a full journey history" do
      it "should add a journey to the history" do
        card.touch_in(aldgate)
        expect { card.touch_out(aldgate) }.to change { card.travel_history }
      end

      it "should increase journey history by 1" do
        card.touch_in(aldgate)
        expect { card.touch_out(aldgate) }.to change { card.travel_history.length }.by 1
      end

    end
  end

end
