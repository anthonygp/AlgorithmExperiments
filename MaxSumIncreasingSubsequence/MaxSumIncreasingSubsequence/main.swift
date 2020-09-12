//
//  main.swift
//  MaxSumIncreasingSubsequence
//
//  Created by Anthony Gonsalves on 12.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func maxSumIncreasingSequence(in numbers: [Int]) -> Int {
    if numbers.isEmpty {
        return Int.min
    }
    
    // we store the maximum sum encountered using the index element i. Finally
    // our goal is to build a `maxSumEncountered` array of same length as input `numbers` array.
    var maxSumEncountered: [Int] = Array(repeating: 0, count: numbers.count)
    
    // O(n * n)
    for (index, element) in numbers.enumerated() {
        var j = index - 1
        var maxSumAtCurrentElement = element
        while j >= 0 {
            if element >= numbers[j] {
                maxSumAtCurrentElement = maxSumEncountered[j] + element
                break
            }
            j -= 1
        }
        maxSumEncountered[index] = maxSumAtCurrentElement
        print(maxSumEncountered)
    }
    // Space complexity will be O(n) usually we negligible as space is super cheap.
    return maxSumEncountered.max() ?? Int.min // O(n)
}

// Driver function.
func main() {
    print("Demonstration of Maximum Increasing Subsequence in a given input array of integers.")
    print("More information can be found at:")
    print("https://www.geeksforgeeks.org/maximum-sum-increasing-subsequence-dp-14/")
    let input = [10, 70, 20, 30, 50, 11, 30]
    print("For the given input: \(input)")
    print("The maximum sum that can be formed is \(maxSumIncreasingSequence(in: input))")
}

main()
