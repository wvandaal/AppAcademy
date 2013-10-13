def primes(num)
  primes = []
  p = 2

  while primes.count < num
    primes << p if is_prime?(p)
    p += 1
  end

  primes 
end

def is_prime?(num)
  (2..num/2).each do |i| 
    return false if num % i == 0
  end
  return true
end

def factorials_rec(num)
  return [1] if num == 1

  factorials = factorials_rec(num - 1)
  factorials << factorials[-1] * num
end

class Array 
  def dups
    dups = {}
    self.uniq.each do |num|
      if self.count(num) > 1
        index = self.index(num)
        indices = [index]
        (index + 1...length).each {|i| indices << i if self[i] == num}
        dups[num] = indices
      end
    end
    dups
  end
end

class String
  def symmetric_substrings
    subs = self.substrings.select{|str| str == str.reverse && str.length > 1 }
  end

  def substrings
    result = []
    chars = self.split("")
    len = chars.size
    (0...len).each do |i|
      (i...len).each do |j|
        result << chars[i..j].join("")
      end
    end
    result.uniq
  end
end