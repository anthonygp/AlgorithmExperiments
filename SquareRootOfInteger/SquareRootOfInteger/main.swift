//
//  main.swift
//  SquareRootOfInteger
//
//  Created by Anthony Gonsalves on 07.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Compute and return the square root of x, where x is guaranteed to be a non-negative integer")


/**
 https://leetcode.com/problems/sqrtx/
 */

func squareRootOfInteger(_ x: Int) -> Int {
    var high = x
    var low  = 0
    
    while low <= high {
        let mid = (high + low) / 2
        if mid * mid < x {
            low = mid + 1
            if (mid + 1) * (mid + 1) > x {
                // we are close enough return here.
                return mid
            }
        } else if mid * mid > x {
            high = mid - 1
        } else {
            return mid
        }
    }
    return 0
}


print("Testing square root 5 \(squareRootOfInteger(5))")
print("Testing square root 101 \(squareRootOfInteger(101))")
print("Testing square root 324 \(squareRootOfInteger(324))")
