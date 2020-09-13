//
//  main.swift
//  MaxSubMatrixSumIn2DMatrix
//
//  Created by Anthony Gonsalves on 13.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/// Class to hold the data of the sub matrix.
class SubMatrix {
    var total = Int.min
    var leftColumn = -1
    var rightColumn = -1
    var topRow = -1
    var bottomRow = -1
}

func maxSumSubMatrix(matrix: [[Int]]) -> SubMatrix {
    
    let rowSize = matrix.count
    let columnSize = matrix[0].count
    
    // This will hold the maximum matrix at any given point in time.
    var globalSubMatrix = SubMatrix()
    
    for left_col in 0..<columnSize {
        // Initialize the running sum.
        var runningColumn = Array(repeating: 0, count: rowSize)
        for right_col in left_col..<columnSize {
            // Add the previously summated column value with the current column.
            for row in 0..<rowSize {
                runningColumn[row] = runningColumn[row] + matrix[row][right_col]
            }
            let localSubMatrix = SubMatrix()
            localSubMatrix.leftColumn = left_col
            localSubMatrix.rightColumn = right_col
            // Run a simple Kadanes algorithm to find the highest.
            kadanesFindMaxSubsequence(singleColumn: runningColumn, subMatrix: localSubMatrix)
            if localSubMatrix.total > globalSubMatrix.total {
                globalSubMatrix = localSubMatrix
            }
        }
    }
    return globalSubMatrix
}

/// Returns a tuple representing start and end index and the max value in the columnArray
func kadanesFindMaxSubsequence(singleColumn: [Int], subMatrix: SubMatrix) {
    let rowSize = singleColumn.count
    var globalMax = singleColumn[0]
    var globalMaxStartRow = 0, globalMaxRowEnd = 0
    
    var localMax = singleColumn[0]
    var localMaxStartRow = 0, localMaxEndRow = 0
    for row in 1..<rowSize {
        let element = singleColumn[row]
        if element + localMax >= element {
            localMax = element + localMax
            localMaxEndRow = row
        } else {
            localMax = element
            localMaxStartRow = row
            localMaxEndRow = row
        }
        if globalMax < localMax {
            globalMax = localMax
            globalMaxStartRow = localMaxStartRow
            globalMaxRowEnd = localMaxEndRow
        }
    }
    subMatrix.topRow = globalMaxStartRow
    subMatrix.bottomRow = globalMaxRowEnd
    subMatrix.total = globalMax
}

// Driver function.
func main() {
    print("Demonstration of the maximum sum in submatrix formed in 2D matrix.")
    print("More information can be found at:")
    print("http://www.geeksforgeeks.org/dynamic-programming-set-27-max-sum-rectangle-in-a-2d-matrix/")
    
    let input =
        [
            [2, 1, -3, -4, 5],
            [0, 6, 3, 4, 1],
            [2, -2, -1, 4, -5],
            [-3, 3, 1, 0, 3]
    ]
    print("For the given matrix: \(input)")
    let subMatrix = maxSumSubMatrix(matrix: input)
    print("The max \(subMatrix.total) sum can be found at topRow:\(subMatrix.topRow), leftColomn:\(subMatrix.leftColumn), bottomRow:\(subMatrix.bottomRow), rightColumn:,\(subMatrix.rightColumn)")
}

main()
