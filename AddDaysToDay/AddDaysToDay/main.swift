//
//  main.swift
//  AddDaysToDay
//
//  Created by Anthony Gonsalves on 11/05/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print(
"""
 Days of the week represented by
 ("Mon", "Tue"..... "Sat", "Sun")

 For a given string S representing day of week and a integer,
 returns the day of the week that is K days later.

 For example, given S = "Wed" and K = 2, the function should
 return "Fri",

 Given S= "Sat" and K = 23, the function should return "Mon"
"""
)

var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

let S = "Sat"
let K = 23

var remainderDays = K % 7
if remainderDays < 0 {
    remainderDays = 7 + remainderDays
}

var new_start = days.firstIndex(of: S) ?? 0
var mutated_days = Array(days[0..<new_start])
var rest_days = Array(days[new_start...])
var allDays = rest_days + mutated_days

print("\n*** when we add \(K) to \(S) days we get \(allDays[remainderDays]) ***")


