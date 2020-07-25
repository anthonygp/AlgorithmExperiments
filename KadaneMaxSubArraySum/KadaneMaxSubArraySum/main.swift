//
//  main.swift
//  KadaneMaxSubArraySum
//
//  Created by Anthony Gonsalves on 25.07.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

let input = [-2, 1, -3, 4, -1, 2, 1, -5, 4]

/**
 This method returns the subarray that has the maximum sum.
 */
func kadanes(input: [Int]) -> Int {
    var localSum = -9999
    var globalSum = Int.min
    
    var localStartIndex = 0
    
    var startOfContinousSubArrayIndex = 0
    var endOfContinousSubArrayIndex = 0
    for (index, element) in input.enumerated() {
        if element > (localSum + element) {
            localSum = element
            localStartIndex = index
        } else {
            localSum = localSum + element
        }
        if localSum > globalSum {
            globalSum = localSum
            endOfContinousSubArrayIndex = index
            startOfContinousSubArrayIndex = localStartIndex
        }
    }
    print("The subarray can be found at \(startOfContinousSubArrayIndex) and \(endOfContinousSubArrayIndex)")
    return globalSum
}

print("The subarray the has maximum sum is \(kadanes(input: input))")


 
