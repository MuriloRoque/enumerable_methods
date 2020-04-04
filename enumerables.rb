module Enumerable
  def my_each
    n = 0
    while n <= size-1
      yield (to_a[n])
      n += 1
    end
  end
end

arr = [1,3,4,8,2]
arr.my_each do |n|
  n*2
end