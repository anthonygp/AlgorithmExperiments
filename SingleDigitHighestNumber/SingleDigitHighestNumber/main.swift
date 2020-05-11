//
//  main.swift
//  Test234
//
//  Created by Anthony Gonsalves on 10/05/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("For a given array find the maximum single digit number")

var array = [-6, -91, 1011, -100, 84, -22, 0, 1, 473]

var maxInt = -10
for number in array {
    if number > -10, number < 10, number > maxInt {
        maxInt = number
    }
}

print("Single digit highest number is \(maxInt)")
