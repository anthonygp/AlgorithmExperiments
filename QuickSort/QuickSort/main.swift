//
//  main.swift
//  QuickSort
//
//  Created by Anthony Gonsalves on 30.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/*
 The sorting occurs in place.
 
 The pivot element at which the partition occurs place a important role. When the
 partition occurs along the pivot element it is to be considered that the pivot element
 is already sorted and is in place such that the elements to the left are lesser than the
 pivot element and those to the right are greater.
 
 There are lot of algorithms that are available for partition logic the best and the
 simplest one is used in this example and the logic is mentioned below.
 1. Take the last element as the pivot or the partition element.
 2. Move left index such that it stops at the element greater than the pivot.
 3. Move right index such that it stops at the element lesser than the pivot.
 4. Swap left and right
 5. Repeat steps 2, 3, 4 until left > right
 6. Finally we found a descent spot for pivot element, i.e whatever index the left is
    holding. Swap elements at left and the right bound.
 
 As we know that the pivot is already sorted in place, then consider sorting the left and
 right elements of the pivot(except pivot). Repeat until there is no longer elements
 left to partition.
 
 Analysis:
 In worst case scenario:
    Consider the input array to be in ascending/descending order. In each and every
    partition the array is unevenly split. If N is the size of the array, then the array
    will be split to size 0 and N-1 sized arrays. So, the work done after complete
    sorting is N + (N - 1) + (N - 2)... = N(N + 1)/2. The time complexity in worst case
    will be O(Nˆ2)
 
 In best case scenario:
    Consider an input array such that the partition occurs exactly in the middle for every
    partitioning in quick sort. Such that at the end we get the structure of a complete binary tree
    when the recursive function stack is considered.
    So, work done per levels of recursion.
        level 0 :   1(N-1)
        level 1 :   2(N/2 - 1)
        level 2 :   4(N/4 - 1)
            .
            .
        level i :   2^i(N/(2^i) - 1)
 
    We know that number of nodes in any given level i is Log(base2)(i).
    so summing the above we get
        Summation(i)[0, lognN] (2^i(N/(2^i) - 1) = NLog(N) - 0.
 
    Visual information about the analysis can found at https://www.youtube.com/watch?v=uXBnyYuwPe8 from
    20: 24 time frame.
 */


func partition(array: inout [Int], leftBound: Int, rightBound: Int) -> Int {
    var left = leftBound
    var right = rightBound - 1
    
    let partitionElement = array[rightBound]
    while left <= right {
        while array[left] <= partitionElement, left <= right {
            left += 1
        }
        while array[right] > partitionElement, left <= right {
            right -= 1
        }
        if left <= right {
            array.swapAt(left, right)
        }
    }
    array.swapAt(rightBound, left)
    return left
}

func quickSort(array: inout [Int], leftBound: Int, rightBound: Int) {
    if leftBound < rightBound {
        let partitionIndex = partition(array: &array,
                                       leftBound: leftBound, rightBound: rightBound)
        quickSort(array: &array,
                  leftBound: leftBound,
                  rightBound: partitionIndex - 1)
        quickSort(array: &array,
                  leftBound: partitionIndex + 1,
                  rightBound: rightBound)
    }
}

// Driver function
func main() {
    print("Demonstration of quick sort.")
    var input = [19, 20, 3, 14, 26, 7, 98, 1, 5]
    print("Given input array:\n\(input)")
    quickSort(array: &input, leftBound: 0, rightBound: input.count - 1)
    print("Sorted array is:\n\(input)")
}

// Drive
main()
