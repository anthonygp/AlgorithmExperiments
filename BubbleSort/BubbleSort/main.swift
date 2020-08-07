//
//  main.swift
//  BubbleSort
//
//  Created by Anthony Gonsalves on 04/06/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

let unsorted = [8, 5, 2, 9, 5, 6, 3]

func bubbleSort(numbers: [Int]) -> [Int] {
    var isSorted = false
    var sortedNumbers = numbers
    var counter = 0
    while isSorted == false {
        for i in 0 ..< (sortedNumbers.count - 1) - counter {
            if sortedNumbers[i] > sortedNumbers[i+1] {
                sortedNumbers.swapAt(i, i+1)
                isSorted = false
                continue
            }
            isSorted = true
        }
        counter = counter + 1
    }
    return sortedNumbers
}

print("Input numbers to be sorted \(unsorted)")
print("Sorted numbers \(bubbleSort(numbers: unsorted))")
