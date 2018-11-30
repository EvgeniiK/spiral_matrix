def random_matrix(size, max=10)
  Array.new(size.times.map { size.times.map { rand(max) }})
end

def spiral(m)
  Enumerator.new do |y|
    center = m.size / 2
    n = 1
    actions = {
        center: lambda { y << m[center][center] if n == 1 },
        left:   lambda {
          c = center+n-1
          until c < center-n
            y << m[center-n][c]
            c -= 1
          end
        },
        down:   lambda { m[center-n+1..center+n].each { |row| y << row.first }},
        right:  lambda { m[center+n][center-n+1..center+n].each { |e| y << e }},
        up:     lambda {
          c = center+n-1
          until c < center-n
            y << m[c][center+n]
            c -= 1
          end
        },
        inc:    lambda { n += 1 }
    }
    command_sequence = actions.keys.cycle
    actions[command_sequence.next].call until n > center
  end
end

m = random_matrix(5)
m.each {|e| p e }
s = spiral(m)
p s.to_a
