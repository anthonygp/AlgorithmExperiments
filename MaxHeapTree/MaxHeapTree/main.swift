//
//  main.swift
//  MaxHeapTree
//
//  Created by Anthony Gonsalves on 24.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

/// Driver
func main() {
    print("Demonstration of max heap construction")
    let input = [10, 20, 30, 40, 50, 25, 33, 41, 100]
    let maxHeap: MaxHeap<Int> = MaxHeap()
    maxHeap.addSequence(sequence: input)
    maxHeap.show()
    print("removed \(maxHeap.remove()!)")
    maxHeap.show()
}

class MaxHeap<T: Hashable & Comparable & CustomStringConvertible> {
    private var contentArray: [T] = []
    
    var peek: T? { contentArray.first }
    
    var size: Int { contentArray.count }
    
    func leftChildIndex(parentIndex: Int) -> Int {
        2 * parentIndex + 1
    }
    
    func rightChildIndex(parentIndex: Int) -> Int {
        2 * parentIndex + 2
    }
    
    func addSequence(sequence: [T]) {
        for element in sequence {
            append(element)
        }
    }
    
    func append(_ element: T) {
        contentArray.append(element)
        var child_i = self.size - 1
        while child_i > 0 {
            let parent_i = parentIndex(for: child_i)
            if  contentArray[parent_i] < contentArray[child_i] {
                contentArray.swapAt(parent_i, child_i)
                child_i = parent_i
            } else { break }
        }
    }
    
    func remove() -> T? {
        let removed = contentArray.first
        contentArray.swapAt(0, self.size - 1)
        contentArray.removeLast()
        var parent_i = 0
        while parent_i < contentArray.count {
            var child_i = leftChildIndex(parentIndex: parent_i)
            if child_i >= self.size { break }
            var child_right_i = rightChildIndex(parentIndex: parent_i)
            child_right_i = child_right_i > self.size - 1 ? child_i : child_right_i
            child_i = (contentArray[child_right_i] > contentArray[child_i]) ? child_right_i : child_i
            if contentArray[parent_i] <= contentArray[child_i] {
                contentArray.swapAt(parent_i, child_i)
                parent_i = child_i
            } else { break }
        }
        
        return removed
    }
    
    func parentIndex(for childIndex: Int) -> Int {
        (childIndex - 1)/2
    }
    
    func show() {
        print(contentArray)
    }
}

main()
