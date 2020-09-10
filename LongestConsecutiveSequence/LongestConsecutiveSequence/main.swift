//
//  main.swift
//  LongestConsecutiveSequence
//
//  Created by Anthony Gonsalves on 10.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/**
 This can be easily done by 2 steps.
 1. Sort the array. The complexity will be O(nLog(n))
 2. Check consecutive elements which have a difference of 1 and are ascending.
 So the over-all complexity will be O(n + nLog(n)) which is not so efficient.
 
 Efficient approach:
 1. Add the numbers in the array to the hash map.
 2. For each number in the array, check the sequence of numbers less than the current element to be present
    in the hash map. continue untill you get the number which are not in the consecutive in the series.
 3. Repeat the step 2 but check for the higher consecutive elements.
 4. Record the longest sequence encountered for each step 2 and 3 combined.
*/
func longestConsecutiveSequence(in numbers: [Int]) -> [Int] {
    var visitInfo: [Int: Bool] = [:]
    
    for element in numbers {
        visitInfo[element] = false
    }
    
    var longestSequenceEncountered: [Int] = []
    for element in numbers {
        var currentLongestSequence = [element]
        visitInfo[element] = true
        
        var backElement = element - 1
        var backElementVisited = visitInfo[backElement]
        while backElementVisited == false {
            currentLongestSequence.insert(backElement, at: 0)
            backElement -= 1
            backElementVisited = visitInfo[backElement]
        }
        
        var frontElement = element + 1
        var frontElementVisited = visitInfo[frontElement]
        while frontElementVisited == false {
            currentLongestSequence.append(frontElement)
            frontElement += 1
            frontElementVisited = visitInfo[frontElement]
        }

        if currentLongestSequence.count > longestSequenceEncountered.count {
            longestSequenceEncountered = currentLongestSequence
        }
    }
    return longestSequenceEncountered
}

// Driver function
func main() {
    print("Find the Longest Consecutive Sequence.")
    print("More details can be found at:")
    print("https://leetcode.com/problems/longest-consecutive-sequence/")
    
    let input = [100, 4, 200, 1, 3, 2]
    print("The longest consecutive sequence for input: \(input) is \(longestConsecutiveSequence(in: input))")
}

main()
