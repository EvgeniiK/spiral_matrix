gem 'rdoc'
require 'rdoc/rdoc'

##
# This class allows to work with matrix spiral output as an enumerable.

class SpiralMatrix
  include Enumerable

  attr_reader :matrix

  DEFAULT_SIZE = 5
  DEFAULT_MAX_RANDOM = 10

  def initialize(arg)
    self.matrix = case arg
                  when Integer
                    SpiralMatrix.random_matrix(arg.abs )
                  when Array
                    arg
                  else
                    SpiralMatrix.random_matrix(DEFAULT_SIZE )
                  end
  end

  def self.random_matrix(size, max=DEFAULT_MAX_RANDOM)
    Array.new(size.times.map { size.times.map { rand(max) }})
  end

  def each(&block)
    return spiral_output.to_enum unless block
    spiral_output.each { |e| yield e }
  end

  def even
    spiral_output.select(&:even?)
  end

  def reverse_even
    even.reverse
  end

  private

  attr_writer :matrix

  def spiral_output
    @spiral_output ||= spiral_iterator
  end

  def matrix_clone
    @matrix_clone ||= matrix.map { |row| row.clone }
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

matrix = SpiralMatrix.random_matrix(5)
sm = SpiralMatrix.new(nil)
matrix.each { |e| p e }
p sm.matrix
p "spiral output to center: #{sm.each { |e| e }}"
p "spiral output from center: #{sm.reverse_each.map { |e| e }}"
p "max: #{sm.max}"
p "even: #{sm.reverse_even}"