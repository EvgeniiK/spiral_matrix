def random_matrix(size, max=10)
  Array.new(size.times.map { size.times.map { rand(max) }})
end

def spiral(m)
  Enumerator.new do |y|
    center = m.size / 2
    n = 1
    actions = {
        center: lambda { n == 1 ? y << [m[center][center]] : [] },
        left:   lambda { m[center-n][center-n..center+n-1].reverse },
        down:   lambda { m[center-n+1..center+n].map { |row| p 'ds1'; row[center-n] }},
        right:  lambda { m[center+n][center-n+1..center+n] },
        up:     lambda { m[center-n..center+n-1].map { |row| p 'ds'; row[center+n] }.reverse },
        inc:    lambda { n += 1; [] }
    }
    command_sequence = actions.keys.cycle
    actions[command_sequence.next].call.each { |e| y << e } until n == center+1
  end
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
    p 'fn'
    until mat.empty?
      actions[command_sequence.next].call.each do |e|
        p 'each'
        y << e
        p 'after each'
      end
    end
  end
end

m = random_matrix(5)
m.each {|e| p e }
s = spiral(m)
p s.next
