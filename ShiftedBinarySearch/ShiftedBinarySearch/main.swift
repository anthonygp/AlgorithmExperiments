//
//  main.swift
//  ShiftedBinarySearch
//
//  Created by Anthony Gonsalves on 14.10.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/**
 More information can be found at  https://leetcode.com/problems/search-in-rotated-sorted-array/
 Find a element in the rotated sorted array.
 Ex: [7, 8, 9, 10, 11, 0, 1, 2, 3]
 
 This is a simple problem.
 
 1. Find the pivot element Index. Pivot Index is the element whose elements in the left and right are greater.
 2. After finding the pivot element, depending on the search element adjust the low and high range with
    respect to the pivot.
    
 In above example:
    Element 0 will be the pivot element which is located at 5th index. Suppose the search
    element is 9, we adjust the range from (0 to 4) and if the search element is 2, we adjust the range from (5 to 8)
    In this problem we also find the smallest element in the rotated sorted array which is nothing
    but the pivot element.
 */

func findSmallestElementIndex(sortedArray: [Int]) -> Int {
    // Modified binary search.
    var low = 0, high = sortedArray.count - 1
    
    // When low == high we will find the pivot element
    while low < high {
        let mid = low + (high - low) / 2
        // if the mid element is greater than the element at the highest bound, then by
        // intuition we know that the pivot lies in right half. ie between mid + 1 to high
        if sortedArray[mid] > sortedArray[high] {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    // low or high, does not matter. Because low == high at the end of the loop.
    return low
}


/// Finds the element if present in the sorted array within the given index range i.e
/// lower to upper bound.
///
/// - Parameters:
///   - searchElement: Element to be searched in the given sorted array.
///   - sortedArray: Rotated sorted array.
/// - Returns: Index of the element in the given array if present else nil will be returned.
func findElement(searchElement: Int, sortedArray: [Int], lowerBound: Int, upperBound: Int) -> Int? {
    // We do a binary search in the array within the given bounds.
    var left = lowerBound, right = upperBound
    while left <= right {
        let mid = left + (right - left) / 2
        if sortedArray[mid] == searchElement {
            return mid
        } else if searchElement < sortedArray[mid] {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return nil
}

// Returns the index of the search element in the given sorted array if present, else return nil.
func findElementInRotatedSortedArray(sortedArray: [Int], searchElement: Int) -> Int? {
    let pivotIndex = findSmallestElementIndex(sortedArray: sortedArray)
    // Ex: [7, 8, 9, 10, 11, 0, 1, 2, 3], pivot element will be 0, if the search element is 2, then the range will
    // be on the right of the pivot element. Else on the right side.
    if searchElement < sortedArray[sortedArray.count - 1]
        && sortedArray[pivotIndex] <= sortedArray[sortedArray.count - 1] {
        return findElement(searchElement: searchElement,
                           sortedArray: sortedArray, lowerBound: pivotIndex, upperBound: sortedArray.count - 1)
    } else {
        return findElement(searchElement: searchElement,
                           sortedArray: sortedArray, lowerBound: 0, upperBound: pivotIndex - 1)
    }
}


/// Driver function
func main() {
    let rotatedSortedArray = [4, 5, 6, 7, 0, 1, 2]
    print("For given input array:\n\(rotatedSortedArray)\n")
    var searchElement = 5
    var indexOfSearchElement = findElementInRotatedSortedArray(sortedArray: rotatedSortedArray,
                                                               searchElement: searchElement)
    print("The search element \(searchElement) can be found at \(indexOfSearchElement)")
    
    searchElement = 100
    indexOfSearchElement = findElementInRotatedSortedArray(sortedArray: rotatedSortedArray,
                                                               searchElement: searchElement)
    print("The search element \(searchElement) can be found at \(indexOfSearchElement)")
}

// Drive
main()
