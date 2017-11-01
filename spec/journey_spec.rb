require 'journey'

describe Journey do

  let(:aldgate) { double( :station,
                          :name => 'Aldgate',
                          :zone => 2) }

  let(:kingsx) { double( :station,
                          :name => 'Kings Cross',
                          :zone => 1) }

  describe '#start' do
    context 'when an oystercard is touching in' do
      it 'returns station name to start point' do
        expect { subject.start(aldgate) }.to change { subject.start_point }.to eq({ station: aldgate.name, zone: aldgate.zone })
        expect { subject.start(kingsx) }.to change { subject.start_point }.to eq({ station: kingsx.name, zone: kingsx.zone })
      end
    end
  end

  describe 'in_journey?' do
    context 'when start point is nil' do
      it { expect(subject.in_journey?).to be(false) }
    end

    context 'when start point holds a value' do
      it 'returns true' do
        subject.start(aldgate)
        expect(subject.in_journey?).to be(true)
      end
    end

  end

  describe '#finish' do
    context 'when an oystercard is touching out' do
      it 'returns station name to end point' do
        expect { subject.finish(aldgate) }.to change { subject.end_point }.to eq({ station: aldgate.name, zone: aldgate.zone })
        expect { subject.finish(kingsx) }.to change { subject.end_point }.to eq({ station: kingsx.name, zone: kingsx.zone })
      end
    end
  end

  describe '#complete' do
    it 'returns a Hash with Date, start_point, and end_point' do
      subject.start(aldgate)
      subject.finish(kingsx)
      expect(subject.complete).to include({ start: { station: aldgate.name, zone: aldgate.zone }, finish: { station: kingsx.name, zone: kingsx.zone } })
    end
  end

  # describe '#fare' do
  #   context 'when a full journey has been successfully completed' do
  #     it 'returns the correct fare' do
  #       expect(subject.fare(1, 6)).to eq(1)
  #     end
  #   end
  # end

end
