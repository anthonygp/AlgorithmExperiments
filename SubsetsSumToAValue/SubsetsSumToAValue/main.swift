//
//  main.swift
//  SubsetsSumToAValue
//
//  Created by Anthony Gonsalves on 13.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func subsetSumTo(targetSum: Int, numbers: [Int]) {
    print("For given input array: \(numbers) and the target sum: \(targetSum)")
    var result: [[Int]] = []
    let subsetCount = findAllTheSubSets(targetSum: targetSum, runningSum: 0,
                                        runningSet: [], result: &result,
                                        numbers: numbers, startIndex: 0)
    print("Total number of subsets that can be made is: \(subsetCount) and the sets are as follows:\n\(result)")
}

func findAllTheSubSets(targetSum: Int, runningSum: Int,
                       runningSet: [Int], result: inout [[Int]],
                       numbers: [Int], startIndex: Int) -> Int {
    /**
     We have 2 basic bounding conditions.
     1. the runnig sum is exceeding the target sum.
     2. the index is out of bounds.
     */
    
    if startIndex >= numbers.count {
        return 0
    }
    
    if runningSum > targetSum {
        return 0
    }
    
    if runningSum == targetSum {
        result.append(runningSet)
        return 1
    }
    
    return
        findAllTheSubSets(targetSum: targetSum, runningSum: runningSum + numbers[startIndex],
                          runningSet: runningSet + [numbers[startIndex]], result: &result,
                          numbers: numbers, startIndex: startIndex + 1) +
        findAllTheSubSets(targetSum: targetSum, runningSum: runningSum,
                          runningSet: runningSet, result: &result,
                          numbers: numbers, startIndex: startIndex + 1)
}



func main() {
    print("Find the subsets of numbers in a given set that sum to a given target value")
    print("More information can be found at:")
    print("https://www.geeksforgeeks.org/subset-sum-problem-dp-25/")
    let input = [2, 3, 5, 5, 8, 10]
    //let input = [3, 34, 4, 12, 5, 2]
    subsetSumTo(targetSum: 10, numbers: input)
}

main()
