require 'journeylog'

describe JourneyLog do
  let(:journey) { double(:journey) }

  let(:journey_class) { double(:journey, :new => journey) }
  subject(:journeylog) { JourneyLog.new(journey_class: journey_class) }

  describe '#new' do
    context 'when creating a new JourneyLog' do
      it 'holds a reference to Journey class' do
        expect(subject.journey_class).to eq(journey_class)
      end
    end
  end

  describe '#start_new_journey' do
    it 'creates a new instance of Journey' do
      expect(subject.start_new_journey).to eq(journey)
    end
  end
end
