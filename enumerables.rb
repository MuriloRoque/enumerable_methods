# rubocop: disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

module Enumerable

  def my_each
    n = 0
    while n <= size-1
      yield (to_a[n])
      n += 1
    end
  end

  def my_each_with_index
    n = 0
    while n <= size - 1
      yield(to_a[n], n)
      n += 1
    end
  end

  def my_select
    result=[]
    my_each do |n|
      result.push(n) if yield(n) 
      n += 1
    end
    return result
  end

end

# rubocop: enable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

arr = [1,3,4,8,2]

arr.my_each do |n|
  print n*2
end

arr.my_each_with_index do |n, m|
  print " #{m}:"
  print n*2
end

arr.my_select do |n|
  n%2==0
end