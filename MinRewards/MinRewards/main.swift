//
//  main.swift
//  MinRewards
//
//  Created by Anthony Gonsalves on 23.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

/// Returns: Reward Array
func minRewards(scores: [Int]) -> [Int] {
    // This is a naive approach.
    
    var rewards = Array(repeating: 1, count: scores.count)
    
    for (index, _) in scores.enumerated() {
        var previousIndex = index - 1
        
        while previousIndex >= 0 {
            let currentIndex = previousIndex + 1
            if scores[previousIndex] > scores[currentIndex],
                rewards[previousIndex] <= rewards[currentIndex] {
                rewards[previousIndex] = rewards[currentIndex] + 1
            } else if scores[previousIndex] < scores[currentIndex],
                rewards[previousIndex] >= rewards[currentIndex] {
                rewards[currentIndex] = rewards[previousIndex] + 1
            } else { break }
            previousIndex -= 1
        }
    }
    // Time Complexity here will be O(n*n).
    return rewards
}

/**
 Efficient
 Find the local minimas and expand from that index untill its peak
*/
func efficientMinRewards(scores: [Int]) -> [Int] {
    let localMinimas = getLocalMinimas(scores: scores)
    var rewards = Array(repeating: 1, count: scores.count)
    for localMinimaIndex in localMinimas {
        expandFrom(minIndex: localMinimaIndex, scores: scores, rewards: &rewards)
    }
    
    return rewards
}

func expandFrom(minIndex: Int, scores: [Int], rewards: inout [Int]) {
    // expand left
    var current = minIndex - 1
    
    while current >= 0 {
        if scores[current] > scores[current + 1], rewards[current] <= rewards[current + 1] {
            rewards[current] = rewards[current + 1] + 1
        } else {
            break
        }
        current -= 1
    }
    
    // expand right
    current = minIndex + 1
    
    while current < scores.count {
        if scores[current] > scores[current - 1], rewards[current] <= rewards[current - 1] {
            rewards[current] = rewards[current - 1] + 1
        } else {
            break
        }
        current += 1
    }
}

// Returns indexes of local minimas.
func getLocalMinimas(scores: [Int]) -> [Int] {
    var localMinimas = [Int]()
    for (i, _) in scores.enumerated() {
        // Check for the first element,
        if i == 0, scores.count >= 2, scores[0] < scores[1] { 
            localMinimas.append(i)
        }
        // Check for the last element,
        else if scores.count - 1 == i, scores.count >= 2, scores[i] < scores[i - 1] {
            localMinimas.append(i)
        } else {
            // Between elements.
            if scores[i] < scores[i + 1], scores[i - 1] > scores[i] {
                localMinimas.append(i)
            }
        }
    }
    return localMinimas
}

/// Driver function
func main() {
    print("Demonstration of Candy Distribution of minimum rewards.")
    print("More information can be found at:")
    print("https://leetcode.com/problems/candy/")
    let scores = /*[1, 0, 2]*/[8, 4, 2, 1, 3, 6, 7, 9, 5]
    print("The minimum candy distribution for scores:")
    print(scores)
    print("The candy count is:")
    let rewards = efficientMinRewards(scores: scores)//minRewards(scores: scores)
    print(rewards)
}

/// Drive
main()
