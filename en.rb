def random_matrix(size, max=10)
  Array.new(size.times.map { size.times.map { rand(max) }})
end

def en(mat)
  Enumerator.new do |y|
    actions = {
        right: lambda { mat.shift },
        down:  lambda { mat.map { |row| row.pop }},
        left:  lambda { mat.pop.reverse },
        up:    lambda { mat.map { |row| row.shift }},
    }
    command_sequence = actions.keys.cycle
    p 'fdf'
    until mat.empty?
      p 'sdfasdfas'
      actions[command_sequence.next].call.each do |e|
        p "from meth #{e}"
        y << e
      end
    end
  end
end

m = random_matrix(5)
m.each {|e| p e }
ev = en(m)
p ev.to_a

p ev.first(5)
p ev.take(5)

ev.each { |v| p "one: #{v}" }
p ev.first(5)
p ev.take(5)
ev.each { |v| p "two: #{v}" }
p ev.to_a
# p "two: #{ev.next}"
# p "three: #{ev.next}"