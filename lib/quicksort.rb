require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array.shift
    left, right = [], []
    array.each do |el|
      if el <= pivot
        left.push(el)
      else
        right.push(el)
      end
    end

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    # p "..."
    # p start
    # p length
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    # # p "...."
    # p pivot_idx
    # p (length - pivot_idx - 1)
    # left-side
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    #right-side
    QuickSort.sort2!(array, pivot_idx + 1, length - (pivot_idx - start) -1, &prc)

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new do |el1, el2|
      el1 <=> el2
    end
    pivot = array[start]
    i = 1
    while i < length
      subject = array[start+i]
      if prc.call(subject, pivot) < 0
        # p 'left'
        pivot_idx = array.index(pivot)
        array.delete_at(start+i)
        array.insert(pivot_idx, subject)
      end
      i+=1
    end
    array.index(pivot)
  end
end
