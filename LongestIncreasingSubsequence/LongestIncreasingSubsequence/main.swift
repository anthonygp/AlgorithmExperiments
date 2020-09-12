//
//  main.swift
//  LongestIncreasingSubsequence
//
//  Created by Anthony Gonsalves on 12.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func longestIncreasingSequence(in numbers: [Int]) -> [Int] {
    if numbers.isEmpty {
        return []
    }
    
    // We store the longest possible chain encountered using the element at index i. Finally
    // our goal is to build a longestChainEncountered` array of same length as input `numbers` array.
    var longestChainEncountered: [[Int]] = Array(repeating: [], count: numbers.count)
    
    // O(n * n)
    for (index, element) in numbers.enumerated() {
        var longestCurrentlyknown = [element]
        var j = index - 1
        while j >= 0 {
            if element > numbers[j] {
                let previousLongSequence = longestChainEncountered[j]
                longestCurrentlyknown.insert(contentsOf: previousLongSequence, at: 0)
                break
            }
            j -= 1
        }
        longestChainEncountered[index] = longestCurrentlyknown
    }
    
    // Results are stored in the array longestChainEncountered. Just fetch which ever is longest.
    var result: [Int] = []
    for element in longestChainEncountered {
        if element.count > result.count {
            result = element
        }
    }
    return result
}

// Driver function.
func main() {
    print("Demonstration of Longest Increasing Subsequence in a given input array of integers.")
    print("More information can be found at:")
    print("https://leetcode.com/problems/longest-increasing-subsequence/")
    let input = [10, 9, 2, 5, 3, 7, 101, 18]
    print("For the given input: \(input)")
    print("The longest subsequence that can be formed is \(longestIncreasingSequence(in: input))")
}

main()
