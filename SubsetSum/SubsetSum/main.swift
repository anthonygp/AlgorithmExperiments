//
//  main.swift
//  SubsetSum
//
//  Created by Anthony Gonsalves on 23.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation


func subSetSum(mainSet: [Int], subSet: [Int],
               startIndex: Int, targetSum: Int, result: inout [[Int]]) {
    if subSet.reduce(0, +) == targetSum {
        result.append(subSet)
        return
    }
    
    for index in startIndex..<mainSet.count {
        let element = mainSet[index]
        if subSet.contains(element) {
            continue
        }
        var addedSubSet = subSet
        addedSubSet.append(element)
        subSetSum(mainSet: mainSet, subSet: addedSubSet,
                  startIndex: index, targetSum: targetSum, result: &result)
    }
}

func main() {
    print("Problems description can be found at \n https://www.geeksforgeeks.org/subset-sum-backtracking-4/")
    let mainSet = [1, 2, 3, 4]
    var result: [[Int]] = []
    print("\nThe subsets of set \(mainSet) are")
    subSetSum(mainSet: mainSet, subSet: [], startIndex: 0, targetSum: 5, result: &result)
    print(result)
}

main()
