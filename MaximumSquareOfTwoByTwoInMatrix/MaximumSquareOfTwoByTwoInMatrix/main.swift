//
//  main.swift
//  MaximumSquareOfTwoByTwoInMatrix
//
//  Created by Anthony Gonsalves on 07.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

let inputMatrix =
[
    [1,     4,      7,      12,     15,     1000],
    [2,     5,      19,     31,     32,     1001],
    [3,     8,      24,     33,     35,     1002],
    [40,    41,     42,     44,     45,     1003],
    [99,    100,    103,    106,    128,    1004]
]

func maximumSquareMatrix(in matrix: [[Int]]) -> [[Int]] {
    var row = 0, column = 0
    
    var globalMax = Int.min
    
    while row+1 < matrix.count, column+1 < matrix.first!.count {
        let localMax = matrix[row][column] + matrix[row][column + 1] +
                        matrix[row + 1][column] + matrix[row + 1][column + 1]
        globalMax = max(globalMax, localMax)
    }
    
    
    return [[]]
}
