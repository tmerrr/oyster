require 'oystercard'

describe Oystercard do

  # mocking Journey class
  let(:journey_class) do
    double(:journey_class, :new => journey)
  end

  let(:journey) do
    double(:journey, :fare => 0, :new_journey? => false,
      :set_start => nil, :set_end => nil,
      :in_journey? => nil, :start_point => nil,
      :end_point => nil, :complete => nil
    )
  end

  # default subject
  let(:card) { Oystercard.new(50, journey_class) }

  # other information
  let(:minfare) { described_class::MIN_FARE }
  let(:maxcredit) { described_class::MAX_VALUE }

  # mock station
  let(:aldgate) { double(:station, :name => 'Aldgate', :zone => 3) }

  describe "#balance" do
    context "when a new card is initialized" do
      it "has a balance equal to minimum fare" do
        expect(subject.balance).to eq minfare
      end
    end
  end

  describe '#top_up' do
    it 'changes balance by amount' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'raises error if exceeding limit' do
      expect { subject.top_up(maxcredit + 1) }.to raise_error RuntimeError
    end
  end

  describe '#touch_in' do
    context "when you don't have enough balance for one journey" do
      it "raise an error" do
        empty_card = described_class.new(0)
        expect { empty_card.touch_in(aldgate) }.to raise_error RuntimeError
      end
    end

    context 'when touching in at Aldgate' do
      it 'changes start point on card' do
        expect(journey).to receive(:set_start).with(aldgate)
        card.touch_in(aldgate)
      end
    end
  end

  describe '#touch_out' do
    context 'when user touches out' do
      it "should reduce by minimum fare" do
        allow(journey).to receive(:fare).and_return(1)
        expect { card.touch_out(aldgate) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
      end
    end

    context 'when touching out at Aldgate' do
      it 'changes end point on card' do
        expect(journey).to receive(:set_end).with(aldgate)
        card.touch_out(aldgate)
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
        expect { card.touch_out(aldgate) }.to change { card.travel_history }
      end

      it "should increase journey history by 1" do
        card.touch_in(aldgate)
        expect { card.touch_out(aldgate) }.to change { card.travel_history.length }.by 1
      end

    end
  end

end
