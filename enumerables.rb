# rubocop: disable Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

module Enumerable

  def my_each
    return to_enum unless block_given?
    n = 0
    while n <= size-1
      yield(to_a[n])
      n += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    n = 0
    while n <= size-1
      yield(to_a[n], n)
      n += 1
    end
  end

  def my_select
    return to_enum unless block_given?
    result=[]
    my_each do |n|
      result.push(n) if yield(n) 
    end
    result
  end

  def my_all?(var = nil)
    result=true
    my_each do |n|
      if block_given?
        result=false unless yield(n)
      elsif var.nil?
        result=false unless n
      else
        result=false unless var===n
      end
    end
    result
  end

  def my_any?(var=nil)
    result=false
    my_each do |n|
      if block_given?
        return result=true if yield(n)
      elsif var.nil?
        return result=true unless n
      else
        return result=true unless var===n
      end
    end
    result
  end

  def my_none?(var=nil)
    result=true
    my_each do |n|
      if block_given?
        return result=false if yield(n)
      elsif var.nil?
        return result=false unless n
      else
        return result=false unless var===n
      end
    end
    result
  end

  def my_count(var=nil)
    result=[]
    if block_given?
      my_each do |n|
        result.push(n) if yield(n) 
      end
    elsif var.nil?
      return self.length
    else
      my_each do |n|
        result.push(n) if n==var
      end
    end
    result.length
  end

  def my_map
    result=[]
    return to_enum unless block_given?
    my_each do |n|
      result.push(yield(n))
    end
    result
  end

  def my_inject(var=nil)
    return to_enum unless block_given?
    if var
      result=var
    elsif var.nil?
      result=self[0]
    end
    my_each do |n|
      result=yield(result, n)
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

print "\n\n"

arr.my_each_with_index do |n, m|
  print "#{m}:#{n*2} / "
end

print "\n\n"

puts [1,2,3,4,5].my_select { |num|  num.even?  }

print "\n"

puts ["ant", "bear", "cat"].my_all? { |word| word.length >= 4 }

print "\n"

puts ["ant", "bear", "cat"].my_any? { |word| word.length >=4 }

print "\n"

puts ["ant", "bear", "cat"].my_none? { |word| word.length >=4 }

print "\n"

ary = [1, 2, 4, 2]
puts ary.my_count

puts ary.my_count(2)

puts ary.my_count{ |x| x%2==0 }

print "\n"

puts (1..4).my_map { |i| i*i }

print "\n"

puts (5..10).inject(1) { |product, n| product * n }
