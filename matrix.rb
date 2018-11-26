class SpiralMatrix
  include Enumerable

  def initialize(size: nil, matrix: nil)
    @size = (size % 2).zero? ? size + 1 : size
    @matrix = matrix || SpiralMatrix.random_matrix(@size)
  end

  def self.random_matrix(size, max=100)
    Array.new(size.times.map { size.times.map { rand(max) }})
  end

  def each(&block)
    return spiral_output.to_enum unless block
    spiral_output.each { |e| yield e }
  end

  # For clarity
  def show
    @matrix.each{ |e| p e }
  end

  def even
    spiral_output.select { |num| num.even? }
  end

  private

  def spiral_output
    @spiral_output ||= spiral_iterator
  end

  def matrix_clone
    @matrix_clone ||= @matrix.map {|row| row.clone}
  end

  def spiral_iterator
    m = matrix_clone
    result = []
    actions = {
        right: lambda { m.shift },
        down:  lambda { m.map { |row| row.pop }},
        left:  lambda { m.pop.reverse },
        up:    lambda { m.map { |row| row.shift }},
    }
    command_sequence = actions.keys.cycle
    result += actions[command_sequence.next].call until m.empty?
    result
  end
end

sm = SpiralMatrix.new(size: 5)
sm.show
sm.each { |e| p e }
p sm.max
p sm.even