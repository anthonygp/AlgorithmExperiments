//
//  main.swift
//  MergeIntervals
//
//  Created by Anthony Gonsalves on 12.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

struct Interval {
    let start: Int
    let end: Int
}

func mergeIntervalsFor(inputIntervals: [Interval]) -> [Interval] {
    // Assumption is the recieved intervals are sorted base on thier start intevals
    if inputIntervals.count == 0 {
        return []
    }
    
    var mergedIntervals: [Interval] = [inputIntervals[0]]
    var i = 1
    while i < inputIntervals.count {
        let currentInterval = inputIntervals[i]
        var lastKnownInterval = mergedIntervals.last!
        // Check to find whether the current interval overlaps with previously added interval.
        if currentInterval.start >= lastKnownInterval.start &&
            currentInterval.start <= lastKnownInterval.end {
            // If found merge the intervals
            let _ = mergedIntervals.popLast()
            lastKnownInterval = Interval(start: lastKnownInterval.start,
                                         end: max(currentInterval.end, lastKnownInterval.end))
            mergedIntervals.append(lastKnownInterval)
        } else {
            // If not found then simply append on the mergedIntervals list.
            mergedIntervals.append(currentInterval)
        }
        i += 1
    }
    // Space complexity is O(n) and time complexity is O(n)
    return mergedIntervals
}

// Driver function.
func main() {
    print("Demonstration of Merging the intervals.")
    print("More information can be found at:")
    print("https://leetcode.com/problems/merge-intervals/")
    print("For the given intervals:")
    
    let intervals = [
        Interval(start: 1, end: 3),
        Interval(start: 2, end: 6),
        Interval(start: 8, end: 10),
        Interval(start: 15, end: 18),
    ]
    
    print("\(intervals)")
    print("The merge intervals can be represented as:")
    print("\(mergeIntervalsFor(inputIntervals: intervals))")
}

main()
