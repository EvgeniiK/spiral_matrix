require './matrix'

describe SpiralMatrix do
  before do
    @matrix = SpiralMatrix.new( [[1, 5, 9],[3, 7, 2],[1, 3, 3]])
    @to_center = [1, 5, 9, 2, 3, 3, 1, 3, 7]
    @from_center = [7, 3, 1, 3, 3, 2, 9, 5, 1]
  end

  describe '#each' do
    let(:index)     { 3 }

    it 'returns elements by spiral to center' do
      expect(@matrix.each.to_a).to eq @to_center
    end

    it 'returns defined number of elements by spiral to center' do
      expect(@matrix.each(index) { |e| e }).to eq @to_center[0..index]
    end
  end

  describe '#reverse_each' do
    it 'returns elements by spiral from center' do
      expect(@matrix.reverse_each.to_a).to eq @from_center
    end
  end

  describe '#reverse_even' do
    it 'returns even elements by spiral from center' do
      expect(@matrix.reverse_even).to eq @from_center.select(&:even?)
    end
  end

  describe '#even' do
    it 'returns even elements by spiral to center' do
      expect(@matrix.reverse_even).to eq @to_center.select(&:even?)
    end
  end

  describe '#enumerator' do

    it 'returns enumerator object' do
      expect(@matrix.enumerator).to be_an(Enumerator)
    end

    let(:elements)     { 3 }

    it 'returns defined number of elements by spiral from center' do
      expect(@matrix.enumerator.take(elements)).to eq @from_center[0..elements-1]
    end

    it 'returns even elements by spiral from center' do
      expect(@matrix.enumerator.select(&:even?)).to eq @from_center.select(&:even?)
    end
  end


end