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
        expect(subject.start(aldgate)).to eq(aldgate.name)
        expect(subject.start(kingsx)).to eq(kingsx.name)
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

  # describe '#finish' do
  #   context 'when an oystercard is touching out' do
  #     it ''
  #   end
  # end

end
