//
//  main.swift
//  MomentOfBulbs
//
//  Created by Anthony Gonsalves on 11/05/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print(
"""
There are N bulbs, numbered from 1 to N, arranged in a row. The
first bulb is plugged to power socket and each successive bulb is
connected to the previous one (the second bulb to the first, the
third bulb to second, etc)

Assume all bulbs are turned off. At a moment K (for K from 0 to N-1),
we turn on the A[K]th bulb. A bulb shines if it is on and all the
previous bulbs are turned on too.

Write a function such that given a array A of N different integers from
1 to N, returns the number of moments for which every turned on bulb
shines.

Given A = [2,1,3,5,4] the function should return 3.
"""
)

let A = [1, 3, 4, 2, 5] //expected 3

// brute force uncomment and check
/*
var bulbStates = Array(repeating: false, count: A.count)

var moments = 0
let bulbs = A
for bulb in bulbs {
   bulbStates[bulb] = true
   var isMoment = true
   for lessBulb in 1..<bulb {
       if bulbStates[lessBulb] == false {
          isMoment = false
          break
       }
   }
   if isMoment == true {
       moments = moments + 1
   }
}
*/

// Optimal solution.
var maximumBulb = 0
var moments = 0
for (index, bulb) in A.enumerated() {
    maximumBulb = max(maximumBulb, bulb)
    if maximumBulb == index + 1 {
        moments = moments + 1
    }
}

print("number of bright moments were \(moments)")



