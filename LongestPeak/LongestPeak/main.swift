//
//  main.swift
//  LongestPeak
//
//  Created by Anthony Gonsalves on 27.07.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

func longestPeak(in inputArray: [Int]) -> [Int] {
    if inputArray.count <= 1 {
        return inputArray
    }
    
    var start = inputArray.startIndex
    var end = inputArray.startIndex
    
    var global = (start: -1, end: -1)
    
    while start <= end, end < inputArray.count-1 {
        var isHavingAscendingSlope = false
        var isHavingDescendingSlope = false
        
        while (end+1) < inputArray.count, inputArray[end] < inputArray[end + 1] {
            end += 1
            isHavingAscendingSlope = true
        }
        while (end+1) < inputArray.count, inputArray[end+1] < inputArray[end] {
            end += 1
            isHavingDescendingSlope = true
        }
        
        let local = (start: start, end: end)
        if  isHavingAscendingSlope, isHavingDescendingSlope,
            (global.end - global.start + 1) < (local.end - local.start + 1) {
            global = local
        }
        
        
        if isHavingDescendingSlope == false, false == isHavingDescendingSlope {
            end += 1
        }
        start = end
    }
    
    
    return (global.start == -1 ? [] : Array(inputArray[global.start...global.end]))
}

//let inputArray = [1, 2, 3, 3, 4, 0, 10, 6, 5, -1, -3, 2, 3]
let inputArray =  [1, 2, 3, 3, 2, 1]//[5, 4, 3, 2, 1, 2, 10, 12]//[5, 4, 3, 2, 1, 2, 1]
print("Longest peak in input Array \(inputArray) is \(longestPeak(in: inputArray))")
