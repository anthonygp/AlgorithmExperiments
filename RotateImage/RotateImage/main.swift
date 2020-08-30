//
//  main.swift
//  RotateImage
//
//  Created by Anthony Gonsalves on 30.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

// Create a transpose.
func transpose(matrix: inout [[Int]]) {
    let rowCount = matrix.count
    guard let columnCount = matrix.first?.count, rowCount == columnCount else {
        return
    }

    for row in 0..<rowCount {
        for col in 0..<row {
            let temp = matrix[row][col]
            matrix[row][col] = matrix[col][row]
            matrix[col][row] = temp
        }
    }
}

// shift columns
func mirror(matrix: inout [[Int]]) {
    let rowCount = matrix.count
    guard let columnCount = matrix.first?.count, rowCount == columnCount else {
        return
    }
    
    for row in 0..<rowCount {
        for column in 0..<columnCount/2 {
            matrix[row].swapAt(column, columnCount-column-1)
        }
    }
}

func print(matrix:  [[Int]]) {
    let rowCount = matrix.count
    for row in 0..<rowCount {
        print(matrix[row])
    }
}

/// Driver
func main() {
    print("Demonstrate rotataion of matrix by 90 degrees.")
    print("More information can be found at ")
    print("https://leetcode.com/problems/rotate-image/")
    
    var input = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]
    print("Input matrix")
    print(matrix: input)
    transpose(matrix: &input)
    mirror(matrix: &input)
    print("Output matrix")
    print(matrix: input)
}

main()
