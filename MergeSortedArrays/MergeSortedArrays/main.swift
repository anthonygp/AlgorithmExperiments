//
//  main.swift
//  MergeSortedArrays
//
//  Created by Anthony Gonsalves on 27.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/*
 We build a special min heap which holds the one element of each of the array at any given point in time.
 We just visit the newer items of the corresponding array of which the element has been popped and build the
 heap by using that newer element.
 */

func mergeSorted(arrays: [[Int]]) -> [Int] {
    var sortedArray: [Int] = []
    
    let minHeapHelper = MinHeapHelper(arrays: arrays)
    
    while let extract = minHeapHelper.extract() {
        sortedArray.append(extract.value)
    }
    
    return sortedArray
}

class MinHeapHelper {
    // We build a min heap containing index of element to be visited of each array.
    struct ArrayInfo {
        var visitingIndex: Int = 0
        let array: [Int]
        
        var value: Int {
            array[visitingIndex]
        }
    }
    
    // This holds all the all sorted arrays.
    let arrays: [[Int]]

    init(arrays: [[Int]]) {
        self.arrays = arrays
        build()
    }
    

    var heap: [ArrayInfo] = []
  
    
    func parentIndex(for childIndex: Int) -> Int {
        (childIndex - 1) / 2
    }
    
    func rightChild(for parentIndex: Int) -> Int {
        parentIndex * 2 + 2
    }
    
    func leftChild(for parentIndex: Int) -> Int {
        parentIndex * 2 + 1
    }
    
    func build() {
        for array in arrays {
            if arrays.count > 0 {
                insert(info: ArrayInfo(visitingIndex: 0, array: array))
            }
        }
    }
    
    func insert(info: ArrayInfo) {
        heap.append(info)
        
        var anamolyIndex = heap.count - 1
        
        while anamolyIndex >= 0 {
            let parent = parentIndex(for: anamolyIndex)
            if heap[anamolyIndex].value < heap[parent].value {
                heap.swapAt(anamolyIndex, parent)
            } else { break }
            anamolyIndex = parent
        }
    }
    
    func extract() -> ArrayInfo? {
        guard let extracted = heap.first else { return nil }
        heap.swapAt(0, heap.count - 1)
        heap.removeLast()
        
        var anamolyIndex = 0
        while anamolyIndex < heap.count {
            
            let leftChild_i = leftChild(for: anamolyIndex)
            if leftChild_i >= heap.count {
                break
            }
            
            var rightChild_i = rightChild(for: anamolyIndex)
            rightChild_i = (rightChild_i < heap.count ) ? rightChild_i : leftChild_i
            
            let minChild = (heap[leftChild_i].value < heap[rightChild_i].value) ? leftChild_i: rightChild_i
            
            if heap[anamolyIndex].value >= heap[minChild].value {
                heap.swapAt(anamolyIndex, minChild)
                anamolyIndex = minChild
            } else { break }
        }
        
        if extracted.visitingIndex + 1 < extracted.array.count {
            var newExtract = extracted
            newExtract.visitingIndex += 1
            insert(info: newExtract)
        }
        
        return extracted
    }
        
}


let even = [1, 3, 5, 7, 9, 23, 29]
let odd = [2, 4, 6, 8, 10, 15]
let another = [10, 20, 30, 50]

let sorted = mergeSorted(arrays: [even, odd, another])
print(sorted)

// Driver function
func main() {
    print("Merge n sorted arrays.")
    print("https://leetcode.com/problems/merge-k-sorted-lists/")
    let sortedInputArrays = [
        [1, 3, 5, 7, 9, 23, 29],
        [2, 4, 6, 8, 10, 15],
        [10, 20, 30, 50]
    ]
    print("For given sorted Input arrays:\n\(sortedInputArrays)")
    print("Merged resultant array is: \(mergeSorted(arrays: sortedInputArrays))")
}

// Drive
main()
