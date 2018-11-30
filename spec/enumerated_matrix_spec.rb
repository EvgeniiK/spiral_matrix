require './enumerated_matrix'

describe 'EnumeratedMatrix' do
  before do
    @matrix = [1, 5, 9],[3, 7, 2],[1, 3, 3]
    @to_center = [1, 5, 9, 2, 3, 3, 1, 3, 7]
    @from_center = [7, 3, 1, 3, 3, 2, 9, 5, 1]
  end

  describe '#spiral' do
    let(:s) {spiral(@matrix)}

    it 'returns enumerator object' do
      expect(s).to be_an(Enumerator)
    end

    it 'returns elements by spiral from center' do
      expect(s.to_a).to eq @from_center
    end

    it 'returns 3 elements by spiral from center' do
      expect(s.take(3)).to eq @from_center[0..2]
    end

    it 'returns even elements by spiral from center' do
      expect(s.select(&:even?)).to eq @from_center.select(&:even?)
    end
  end
end

