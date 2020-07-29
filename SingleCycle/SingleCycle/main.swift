//
//  main.swift
//  SingleCycle
//
//  Created by Anthony Gonsalves on 25.07.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

// [1, -1, 1, -1]
func hasSingleCycle(input: [Int]) -> Bool {    
    var uniques = Set<Int>()

    var startIndex = 0
    for _ in 0..<input.count { // loop until count start from 0 to N(Array length)
        let visitedIndex = calculate(offset: input[startIndex], length: input.count, index: startIndex)
        uniques.insert(visitedIndex)
        if visitedIndex == 0 && uniques.count < input.count {
            return false
        }
        startIndex = visitedIndex
    }
    
    return uniques.count == input.count
}

func calculate(offset: Int, length: Int, index: Int) -> Int {
    let jumpedIndex = (index + offset) % length
    if jumpedIndex < 0 {
        return (length ) + jumpedIndex
    }
    return jumpedIndex
}

let input = [1, -1, 1, -1]//[2, 3, 1, -4, -4, 2]
let isProvidedArrayCydle = hasSingleCycle(input: input)
print(isProvidedArrayCydle ? "Provided Array is a cycle": "Provided Array is not a cycle")
