//
//  main.swift
//  MedianOfTwoSortedArrays
//
//  Created by Anthony Gonsalves on 27.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 Median of 2 sorted arrays.
 
 Given 2 arrays X = [x1, x2, x3, x4, x5, x6] and Y = [y1, y2, y3, y4, y5, y6, y7, y8]
 
 In the above case we use binary search to solve the problem.
 Take the array of minimum length, In the above case it is X because it has only 6 elements.
 
 Find the midPoint such that
 MajorMid = (Length(X) + Length(Y)) /2
 also this MajorMid = PartitionX + PartitionY
 
 we run a binary search and to follow the following conditions.
 
 if partition has occured in X is at x2 then in Y it is at y5, since MajorMid is always 14 (7 + 8)
 partitionX is driven by binary search, so it is known.
 partitionY = MajorMid - partitionX
 
 After this we check
 x2 < y6
 x3 > y5
 
 if so then
 1. In case of even lenght of lenghtX + lengthY,
    avg(max(x2, y5), min(x3, y6))
 
 2. In case of odd length.
    max(x2, y5)
*/

func medianOfTwoArrays(arrayA: [Int], arrayB: [Int]) -> Float {
    
    // our assumption is arrayX will contain the array with minimum elements and arrayY will contain the
    // array with higher number of elements.
    let arrayX: [Int]
    let arrayY: [Int]
    (arrayX, arrayY) = (arrayA.count < arrayB.count) ? (arrayA, arrayB) : (arrayB, arrayA)
    
    var low = 0
    var high = arrayX.count
    
    let majorMid = (arrayA.count + arrayB.count + 1) / 2
    while low <= high {
        let partitionX = (low + high) / 2
        let partitionY = majorMid - partitionX
        
        let xMin = (partitionX == 0) ? Int.min : arrayX[partitionX - 1]
        let xMax = (partitionX == arrayX.count) ? Int.max: arrayX[partitionX]
        
        let yMin = (partitionY == 0) ? Int.min : arrayY[partitionY - 1]
        let yMax = (partitionY == arrayY.count) ? Int.max: arrayY[partitionY]
        
        if xMin > yMax { // We are far to the right
            high = partitionX - 1
        } else if xMax < yMin {  // We are far to the left
            low = partitionX + 1
        } else {
            // xMin < yMax and yMin < xMax, we reached the spot.
            if (arrayX.count + arrayY.count) % 2 == 0 {
                return Float(max(xMin, yMin) + min(xMax, yMax)) / 2
            } else {
                return Float(max(xMax, yMax))
            }
        }
    }
    return Float.greatestFiniteMagnitude
}

// Driver function
func main() {
    print("Median of 2 sorted arrays.")
    print("More description can be found at:\nhttps://leetcode.com/problems/median-of-two-sorted-arrays/")
    print("Also refer:\nhttps://www.youtube.com/watch?v=LPFhl65R7ww")
    
    let inputA = [1, 3, 8, 9, 15]
    let inputB = [7, 11, 19, 21, 18, 19]
    print("Given inputArrayA: \(inputA)\ninputArrayB: \(inputB)")
    print("The median is \(medianOfTwoArrays(arrayA: inputA, arrayB: inputB))")
}

// Drive
main()
