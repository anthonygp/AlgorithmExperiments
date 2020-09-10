//
//  main.swift
//  SubarraySort
//
//  Created by Anthony Gonsalves on 10.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func subArraySort(deffectedArray: [Int]) -> (Int, Int) {
    var maxOutOfOrder = Int.min
    var minOutOfOrder = Int.max
    for index in 0..<deffectedArray.count {
        if isOutOfOrder(for: index, array: deffectedArray) == true {
            maxOutOfOrder = max(deffectedArray[index], maxOutOfOrder)
            minOutOfOrder = min(deffectedArray[index], minOutOfOrder)
        }
    }

    if minOutOfOrder == Int.min, maxOutOfOrder == Int.max {
        return (-1, -1)
    }
    
    var subArrayStartIndex = 0
    while deffectedArray[subArrayStartIndex] <= minOutOfOrder {
        subArrayStartIndex += 1
    }
    
    var subArrayEndIndex = deffectedArray.count - 1
    while deffectedArray[subArrayEndIndex] >= maxOutOfOrder {
        subArrayEndIndex -= 1
    }
    
    return (subArrayStartIndex, subArrayEndIndex)
}

func isOutOfOrder(for index: Int, array: [Int]) -> Bool {
    if index > 0,  array[index] < array[index - 1] {
        return true
    }
    if index < array.count - 1 , array[index] > array[index + 1] {
        return true
    }
    return false
}

// Driver function
func main() {
    let deffectedSortedArray = [2, 6, 4, 8, 10, 9, 15]
    // let deffectedSortedArray = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19]

    print("Demonstration of subarrray sort. More information can be found at")
    print("https://leetcode.com/problems/shortest-unsorted-continuous-subarray/")

    print("Input array: \(deffectedSortedArray)")
    print("Index range to be sorted (startIndex, endIndex) is \(subArraySort(deffectedArray: deffectedSortedArray))")
}

main()
