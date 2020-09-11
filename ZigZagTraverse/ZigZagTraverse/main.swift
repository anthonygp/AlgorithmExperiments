//
//  main.swift
//  ZigZagTraverse
//
//  Created by Anthony Gonsalves on 11.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

extension Array where Element == [Int] {
    var rowSize: Int {
        return count
    }
    
    var columnSize: Int {
        return first?.count ?? 0
    }
}

func zigZagTraverse(matrix: [[Int]]) -> [Int] {
    var flip = false
    
    let maxDiagnols = matrix.rowSize + matrix.columnSize - 1
    
    var column = 0, row = 0
    var diagnols = [[Int]]()

    for _ in 0..<maxDiagnols {
        flip = !flip
        let diagnol = getDiagnol(matrix: matrix, row: row, column: column, flipped: flip)
        diagnols.append(diagnol)
        if row < matrix.rowSize - 1 {
            row += 1
        }
        else if column < matrix.columnSize - 1 {
            column += 1
        }
    }
    return diagnols.flatMap { $0 }
}

func getDiagnol(matrix: [[Int]], row: Int, column: Int, flipped: Bool) -> [Int] {
    var i = row
    var j = column

    var diagnol: [Int] = []
    while i >= 0, j < matrix.columnSize {
        let element = matrix[i][j]
        if flipped {
            diagnol.insert(element, at: 0)
        } else {
            diagnol.append(element)
        }
        i -= 1
        j += 1
    }
    return diagnol
}

// Debugging is difficult as lots of steps are involved
func zigZagTraverseBoring(matrix: [[Int]]) -> [Int] {
    enum Direction {
        case up
        case down
    }
    
    var column = 0, row = 0
    var direction = Direction.down
    var result = [Int]()
    while column < matrix.columnSize && row < matrix.rowSize {
        result.append(matrix[row][column])
        switch direction {
        case .down:
            if column == 0 || row == matrix.rowSize - 1 {
                direction = .up
                if row == matrix.rowSize - 1 {
                    column += 1
                } else {
                    row += 1
                }
            } else {
                column -= 1
                row += 1
            }
        case .up:
            if row == 0 || column == matrix.columnSize - 1 {
                direction = .down
                if column == matrix.columnSize - 1 {
                    row += 1
                } else {
                    column += 1
                }
            } else {
                column += 1
                row -= 1
            }
        }
    }
    return result
}

func main() {
    let input = [
        [ 1, 3, 4, 10],
        [ 2, 5, 9, 11],
        [ 6, 8, 12, 15],
        [ 7, 13, 14, 16]
    ]

    print("Implementation of zig zag traversal of a 2D square matrix")
    print("More information can be found at:")
    print("https://leetcode.com/problems/diagonal-traverse/")
    print("Input array ")
    input.forEach{ print($0) }
    print("The output using elegant method is \(zigZagTraverse(matrix: input))")
    print("The output using boring method is \(zigZagTraverseBoring(matrix: input))")
}

main()
