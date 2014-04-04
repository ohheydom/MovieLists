class Array
  def self.duplicate_hashes(ary)
    ary.reduce(Hash.new(0)) { |a, e| a[e] += 1; a }.select {
      |k, v| v > 1 }.reduce({}) { |a, e| a[e.first] = e.last; a }
  end
end
