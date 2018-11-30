def spiral(m)
  Enumerator.new do |y|
    center = m.size / 2
    n = 1
    actions = {
        down:   lambda { (center-n+1..center+n).each { |i| y << m[i][center-n] }},
        right:  lambda { m[center+n][center-n+1..center+n].each { |e| y << e }},
        up:     lambda {
          c = center+n-1
          until c < center-n
            y << m[c][center+n]
            c -= 1
          end
        },
        left:   lambda {
          c = center+n-1
          until c < center-n
            y << m[center-n][c]
            c -= 1
          end
        },
        inc:    lambda { n += 1 }
    }
    command_sequence = actions.keys.cycle
    y << m[center][center]
    actions[command_sequence.next].call until n > center
  end
end
