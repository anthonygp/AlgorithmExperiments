//
//  main.swift
//  PartitioningToKEqualSubsets
//
//  Created by Anthony Gonsalves on 13.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation


func partition(array: [Int], bucketCount: Int, runningSum: Int, targetSum: Int,
               resultSubsets: inout [[Int]], runningSet: [Int],
               isVisited: inout [Bool], startIndex: Int) -> Bool {
    
    /**
        There are 2 bounding conditions.
        1. Bucket count hits 0
        2. We have reached target sum.
     */
    
    // case 1
    if bucketCount == 0 {
        return true
    }
    
    // case 2
    if targetSum == runningSum {
        resultSubsets.append(runningSet)
        let isBucketFilled = partition(array: array, bucketCount: bucketCount - 1,
                                       runningSum: 0, targetSum: targetSum,
                                       resultSubsets: &resultSubsets, runningSet: [],
                                       isVisited: &isVisited, startIndex: 0)
        return isBucketFilled
    }
    
    for index in startIndex..<array.count {
        if isVisited[index] == false {
            isVisited[index] = true
            let isBucketFilled = partition(array: array, bucketCount: bucketCount,
                                            runningSum: runningSum + array[index], targetSum: targetSum,
                                            resultSubsets: &resultSubsets, runningSet: runningSet + [array[index]],
                                            isVisited: &isVisited, startIndex: index)
            
            if isBucketFilled == true {
                return true
            }
            isVisited[index] = false
        }
    }
    
    return false
}

func performPartitioning(array: [Int], bucketSize: Int) {
    let totalSum = array.reduce(0, +)
    if bucketSize <= 0 || bucketSize > array.count {
        print("Bucket size should be between 0 and array size value.")
    }
    else if totalSum % bucketSize != 0 {
        print("The subsets cannot be achieved because the target sum for each bucket is fraction.")
    }
    else {
        var result = [[Int]]()
        var isVisited: [Bool] = Array(repeating: false, count: array.count)
        let partitionSuccess = partition(array: array, bucketCount: bucketSize, runningSum: 0,
                                         targetSum: totalSum/bucketSize,
                                         resultSubsets: &result, runningSet: [],
                                         isVisited: &isVisited, startIndex: 0)
        if partitionSuccess {
            print("Subsets found are:")
            print(result)
        } else {
            print(result)

            print("Error in finding the subsets.")
        }
    }
}

// Driver function.
func main() {
    print("Demonstration of Partitioning of Array into K equal subsets.")
    print("More information can be found at:")
    print("https://leetcode.com/problems/partition-equal-subset-sum/")
    let input = [1, 5, 11, 5]
    print("For given input:\n\(input)")
    performPartitioning(array: input, bucketSize: 2)
}

main()
