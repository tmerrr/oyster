require 'status'

describe Status do

  subject { described_class.new }
  let(:start) { double(:station) }

  describe 'creation' do
    it 'initializes without start' do
      expect(subject.start).to be_nil
    end
  end

  describe '#set_start' do
    before(:each) { subject.set_start(start) }

    it 'can change entry station' do
      expect(subject.start).to be start
    end
  end

  describe '#clear' do
    subject { described_class.new(start: start) }
    before(:each) { subject.clear }

    it 'sets start to nil' do
      expect(subject.start).to be_nil
    end
  end

  describe '#clear?' do
    context 'when start is non-nil' do
      subject { described_class.new(start: start) }

      it 'is false' do
        expect(subject).to_not be_clear
      end
    end

    context 'when start is nil' do
      subject { described_class.new }

      it 'is true' do
        expect(subject).to be_clear
      end
    end
  end
end
