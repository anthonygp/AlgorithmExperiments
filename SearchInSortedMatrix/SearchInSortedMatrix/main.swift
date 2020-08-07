//
//  main.swift
//  SearchInSortedMatrix
//
//  Created by Anthony Gonsalves on 07.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

/**
 Given a Matrix (row * col), The elements of rows and columns are sorted. Find the given number.
 Write a function that solves the above problem and returns position of the index if found else
 returns a -1 -1 pair.
 */



let inputMatrix =
[
    [1,     4,      7,      12,     15,     1000],
    [2,     5,      19,     31,     32,     1001],
    [3,     8,      24,     33,     35,     1002],
    [40,    41,     42,     44,     45,     1003],
    [99,    100,    103,    106,    128,    1004]
]



/**
 This method searchs the sorted 2d Matrix for a given number. This returns a (row, col) relating to the
 given number if found, else returns (-1, -1).
 */
func searchSortedMatrix(_ matrix: [[Int]], number: Int) -> (Int, Int) {
    
    var row = 0, col = matrix.first!.count - 1
    
    while row < matrix.count, col >= 0 {
        if matrix[row][col] > number {
            col -= 1
        } else if matrix[row][col] < number {
            row += 1
        } else {
            // voila!! we found the number.
            return (row, col)
        }
    }
    
    return (-1, -1)
}


print("Input matrix \n\(inputMatrix)")
print("The number \(44) can be found at \(searchSortedMatrix(inputMatrix, number: 10055))")

