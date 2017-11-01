require 'journeylog'

describe JourneyLog do

  # journey objects
  let(:journey) { double(:journey) }
  let(:journey_class) { double(:journey, :new => journey) }

  # status objects
  let(:status) { double(:status, set_start: nil) }
  let(:status_class) { double(:status, :new => status) }

  # general subject
  subject(:journeylog) do
    JourneyLog.new(
      journey_class: journey_class, 
      status_class: status_class
    )
  end

  describe '#new' do
    context 'when creating a new JourneyLog' do
      it 'holds a reference to Journey class' do
        expect(subject.journey_class).to eq(journey_class)
      end

      it 'holds a reference to Status class' do
        expect(subject.status).to eq(status)
      end

      it 'has journeys array' do
        expect(subject.journeys).to be_a Array
      end

      it 'has empty journeys array' do
        expect(subject.journeys).to be_empty 
      end
    end
  end

  describe '#new_journey' do

    before(:each) { expect(status).to receive(:set_start).with(:start) }
    it 'creates a new instance of Journey' do
      subject.new_journey(:start)
    end
  end

  describe '#complete_journey' do
  end

  describe '#fare' do
    context 'when completing valid journey' do
      before(:each) { allow(status).to receive(:clear?).and_return(false) }
      it 'returns 1' do
        expect(subject.fare(:station)).to eq 1
      end
    end

    context 'when starting valid journey' do
      before(:each) { allow(status).to receive(:clear?).and_return(true) }
      it 'returns 0' do
        expect(subject.fare).to eq 0
      end
    end

    context 'when starting invalid journey' do
      before(:each) { allow(status).to receive(:clear?).and_return(false) }
      it 'returns 6' do
        expect(subject.fare).to eq 6
      end
    end

    context 'when ending invalid journey' do
      before(:each) { allow(status).to receive(:clear?).and_return(true) }
      it 'returns 6' do
        expect(subject.fare(:station)).to eq 6
      end
    end
  end
end
