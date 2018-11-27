gem 'rdoc'
require 'rdoc/rdoc'

##
# This class allows to work with matrix spiral output as an enumerable.

class SpiralMatrix
  include Enumerable

  ##
  # Get matrix array
  attr_reader :matrix

  ##
  # Default size of the matrix with random values if no parameter was given.
  DEFAULT_SIZE = 5
  ##
  # Default max random value of the element in the matrix.
  DEFAULT_MAX_RANDOM = 10

  ##
  # Can receive integer(size) to generate matrix with random values.
  # Can receive array(matrix).
  # Can receive nothing - it will generate matrix with random values of the default size.
  def initialize(arg=nil)
    self.matrix = case arg
                  when Integer
                    SpiralMatrix.random_matrix(arg.abs )
                  when Array
                    arg
                  else
                    SpiralMatrix.random_matrix(DEFAULT_SIZE )
                  end
  end

  ##
  # Generates random matrix on the output
  # First parameter is size of the matrix
  # Second parameter optional - it is max random value of the element in the matrix.
  def self.random_matrix(size, max=DEFAULT_MAX_RANDOM)
    Array.new(size.times.map { size.times.map { rand(max) }})
  end

  ##
  # Enumerating from the outer side of the matrix to the center
  # There is #reverse_each method that returns values from the center
  # Can receive number of elements to use with the first parameter
  def each(elements=nil, &block)
    elements = elements || spiral_output.length
    return spiral_output.to_enum unless block
    spiral_output[0..elements].each { |e| yield e }
  end

  ##
  # Shows even elements of the matrix from the outer side of the matrix to the center
  def even
    spiral_output.select(&:even?)
  end

  ##
  # Shows even elements of the matrix from the center of the matrix to the outer side
  def reverse_even
    even.reverse
  end

  private

  attr_writer :matrix

  def spiral_output
    @spiral_output ||= spiral_iterator
  end

  ##
  # Deep clone of the two dimensional matrix
  def matrix_clone
    @matrix_clone ||= matrix.map { |row| row.clone }
  end

  ##
  # Get spiral sequence by cycle executing direction functions that removes
  # outputted values
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

matrix = SpiralMatrix.random_matrix(5)
sm = SpiralMatrix.new(matrix)
matrix.each { |e| p e }
p sm.matrix
p "spiral output to center: #{sm.each { |e| e }}"
p "spiral output from center: #{sm.reverse_each(3).map { |e| e }}"
p "max: #{sm.max}"
p "even: #{sm.reverse_even}"