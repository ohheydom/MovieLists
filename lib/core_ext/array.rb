class Array

  def self.duplicate_hashes(ary)
    ary.inject(Hash.new(0)) { |h,e| h[e] += 1; h }.select {
    |k,v| v > 1 }.inject({}) { |r, e| r[e.first] = e.last; r }
  end

end
