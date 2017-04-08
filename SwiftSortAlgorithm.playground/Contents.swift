//: Playground - noun: a place where people can play

import UIKit

/* Selection Sort */

func selectionsSortRecursive<T:Comparable>(list : inout [T]) {
  var start = 0
  selectionsSortRecursive(list: &list , start: &start)
}


func selectionsSortRecursive<T:Comparable>(list:inout [T], start : inout Int) {
 
  if start < list.count - 1{
    swapValuesInArray(list: &list, index1: start, index2: findMinimumIndex(list: list, start: start))
    start += 1
    selectionsSortRecursive(list: &list, start: &start)
  }
}


func findMinimumIndex<T:Comparable>(list:[T], start : Int)-> Int{
  
  var minPosition = start
  
  for i in start+1..<list.count {
    
    if list[minPosition] >= list[i] {
      minPosition = i
    }
  }
  
  return minPosition
}

func swapValuesInArray<T:Comparable>(list: inout [T], index1:Int, index2:Int) {
  
  var temp:T
  
  if index1 != index2 {
    
    temp = list[index1]
    list[index1] = list[index2]
    list[index2] = temp
    
  }
}

var numberList = [5,2,10,4,9,13,1]
selectionsSortRecursive(list: &numberList)



func quicksort<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { return a }
  
  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }
  
  return quicksort(less) + equal + quicksort(greater)
}

//let list = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
//quicksort(list)


func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
  let pivot = a[high]
  
  var i = low
  for j in low..<high {
    if a[j] <= pivot {
      (a[i], a[j]) = (a[j], a[i])
      i += 1
    }
  }
  
  (a[i], a[high]) = (a[high], a[i])
  return i
}

var list = [ 10, 0, 3, 9, 2, 14, 8 ] //26, 27, 1, 5, 8, -1, 8 ]
let p = partitionLomuto(&list, low: 0, high: list.count - 1)
list  // show the results


func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
  if low < high {
    let p = partitionLomuto(&a, low: low, high: high)
    quicksortLomuto(&a, low: low, high: p - 1)
    quicksortLomuto(&a, low: p + 1, high: high)
  }
}

quicksortLomuto(&list, low: 0, high: list.count - 1)

func insertionSort<T:Comparable>(_ list: [T], _ isOrderedBefore: (T,T)->Bool)->[T]{
  
  var mutableList = list
  
  for i in 1..<list.count {
    
    var j = i
    let temp = list[j]
    
    while j > 0 && isOrderedBefore(temp,mutableList[j-1]) {
      mutableList[j] = mutableList[j-1]
      j -= 1
    }
    
    mutableList[j] = temp
    
  }
  
  return mutableList
}

var listForInsertionSort = [ 10, -1, 3, 9, 2, 27]  //, 8, 5, 1, 3, 0, 26 ]
var test = insertionSort(listForInsertionSort, { (before, after)  in
  return before < after
})

print(test)


class Employee {
  
  var givenName:String
  var surName:String
  
  init(givenName:String, surName:String) {
    self.givenName = givenName
    self.surName = surName
  }
}

let employList = [Employee(givenName: "david", surName: "A"),
                  Employee(givenName: "bob", surName: "A"),
                  Employee(givenName: "ellis", surName: "C"),
                  Employee(givenName: "jordan", surName: "C"),
                  Employee(givenName: "michelle", surName: "F")
                 ]


print(employList.sorted(by: {
  
  return $0.surName < $1.surName
  
  }).sorted(by: {
    return $0.givenName < $1.givenName
  })
)

  
  

//print(employList)



extension Employee : CustomStringConvertible {
  

  var description: String {
    
    let text = self.givenName + " " + self.surName
    return text
  }
}
