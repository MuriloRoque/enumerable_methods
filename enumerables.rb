# rubocop: disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

module Enumerable

  def my_each
    n = 0
    while n <= size-1
      yield(self[n])
      n += 1
    end
  end

  def my_each_with_index
    n = 0
    while n <= size-1
      yield(self[n], n)
      n += 1
    end
  end

  def my_select
    result=[]
    my_each do |n|
      result.push(n) if yield(n) 
    end
    result
  end

  def my_all?
    result=true
    my_each do |n|
      result=false unless yield(n)
    end
    result
  end

  def my_any?
    result=false
    my_each do |n|
      return result=true if yield(n)
    end
    result
  end

  def my_none?
    result=true
    my_each do |n|
      return result=false if yield(n)
    end
    result
  end
end

# rubocop: enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

arr = [1,3,4,8,2]

arr.my_each do |n|
  print n*2
  print " "
end

print "\n"

arr.my_each_with_index do |n, m|
  print "#{m}:#{n*2} / "
end

print "\n"

puts [1,2,3,4,5].my_select { |num|  num.even?  }

print "\n"

puts ["ant", "bear", "cat"].my_all? { |word| word.length >= 4 }

print "\n"

puts ["ant", "bear", "cat"].my_any? { |word| word.length >=4 }

print "\n"

puts ["ant", "bear", "cat"].my_none? { |word| word.length >=4 }