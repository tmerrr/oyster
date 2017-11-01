require 'journey'

describe Journey do

  let(:fares) { {penalty: 6, min_fare: 1} }
  subject { described_class.new(**fares) }

  let(:aldgate) { double( :station,
                          :name => 'Aldgate',
                          :zone => 2) }

  let(:kingsx) { double( :station,
                          :name => 'Kings Cross',
                          :zone => 1) }

  describe '#set_start' do
    context 'when an oystercard is touching in' do
      it 'returns station name to start point' do
        expect { subject.set_start(aldgate) }.to change { subject.start_point }
          .to eq({ station: aldgate.name, zone: aldgate.zone })
        expect { subject.set_start(kingsx) }.to change { subject.start_point }
          .to eq({ station: kingsx.name, zone: kingsx.zone })
      end
    end
  end

  describe 'in_journey?' do
    context 'when start point is nil' do
      it { expect(subject.in_journey?).to be(false) }
    end

    context 'when start point holds a value' do
      it 'returns true' do
        subject.set_start(aldgate)
        expect(subject.in_journey?).to be(true)
      end
    end

  end

  describe '#set_end' do
    context 'when an oystercard is touching out' do
      it 'returns station name to end point' do
        expect { subject.set_end(aldgate) }.to change { subject.end_point }
          .to eq({ station: aldgate.name, zone: aldgate.zone })
        expect { subject.set_end(kingsx) }.to change { subject.end_point }
          .to eq({ station: kingsx.name, zone: kingsx.zone })
      end
    end
  end

  describe '#complete' do
    it 'returns a Hash with Date, start_point, and end_point' do
      subject.set_start(aldgate)
      subject.set_end(kingsx)
      expect(subject.complete)
        .to include({
          start: { station: aldgate.name, zone: aldgate.zone },
          finish: { station: kingsx.name, zone: kingsx.zone }
        })
    end
  end

  describe '#fare' do
    context 'when a full journey has been successfully completed' do
      it 'returns the correct fare' do
        subject = described_class.new(**fares,
                                      start_point: aldgate,
                                      end_point: kingsx)
        expect(subject.fare).to eq(1)
      end
    end

    context 'when a journey is starting' do
      it 'returns the no fare' do
        subject = described_class.new(**fares)
        expect(subject.fare).to eq(0)
      end
    end

    context 'when touching in twice' do
      it 'returns penalty fare' do
        subject = described_class.new(**fares, start_point: aldgate)
        expect(subject.fare).to eq(6)
      end
    end

    context 'when touching out twice' do
      it 'returns penalty fare' do
        subject = described_class.new(**fares, end_point: aldgate)
        expect(subject.fare).to eq(6)
      end
    end
  end
end
