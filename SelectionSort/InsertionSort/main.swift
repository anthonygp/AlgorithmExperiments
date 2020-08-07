//
//  main.swift
//  InsertionSort
//
//  Created by Anthony Gonsalves on 04/06/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

let unsorted = [8, 5, 2, 9, 5, 6, 3]

func insertionSort(numbers: [Int]) -> [Int] {
    var unsorted = numbers
    for i in 0..<unsorted.count {
        var rightBound = i

        while rightBound > 0, unsorted[rightBound] < unsorted[rightBound-1] {
            unsorted.swapAt(rightBound, rightBound-1)
            rightBound = rightBound - 1
        }
    }
    return unsorted
}


print("Input numbers to be sorted \(unsorted)")
print("Sorted numbers \(insertionSort(numbers: unsorted))")
