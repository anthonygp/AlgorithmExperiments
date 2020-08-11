//
//  main.swift
//  MaxNonAdjacentSum
//
//  Created by Anthony Gonsalves on 10.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

/**
 geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
 */

func maxNonAdjacentElementSum(from numbers: [Int]) -> Int {
    if numbers.count == 1 {
        return numbers[0]
    }

    var withLast = numbers[0]
    var withoutLast = 0
    for i in 1..<numbers.count {
       if withoutLast + numbers[i] > withLast {
            let temp = withLast
            withLast = withoutLast + numbers[i]
            withoutLast = temp
        } else {
            withoutLast = withLast
        }
    }
    
    return max(withLast, withoutLast)
}
 
let inputNumbers = [7,10,12,7,9,14]
print("Max sum such that no two elements are adjacent for array \n\(inputNumbers) is \(maxNonAdjacentElementSum(from: inputNumbers))")
