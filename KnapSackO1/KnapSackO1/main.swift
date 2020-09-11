//
//  main.swift
//  KnapSackO1
//
//  Created by Anthony Gonsalves on 11.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

struct Item {
    let weight: Int
    let value: Int
}

/// Returns the optimum value for the given (Weight, Value) tuples
func knapSack01(items: [Item], targetWeight: Int) -> Int {
    
    /**
     At any given point value in knapSack[i][j] represents the optimum value that can be made with
     given i items and j weight.
     
     We create a chart of knapSack[i][j] chart sized [NumberOfItems][TargetWeight]
     
     knapSack[i][j] = max ( knapSack[i-1][j], knapSack[i][j-weight_of_i] + value_of_i )
     i represents the number of items included.
     j represents the weight of the i-th item
     */
    
    var knapSack = Array(repeating: Array(repeating: 0, count: targetWeight + 1), count: items.count + 1)
    
    for index_item in 1...items.count {
        for index_weight in 0...targetWeight {
            let item = items[index_item-1]
            // last known optimum value for the weight
            let lastKnownOptimumValue = safeValue(knapSack: knapSack,
                                                  row: index_item - 1,
                                                  column: index_weight) ?? 0
            
            // Optimum value considering the current item as well
            
            
            let optimumValueWithoutCurrentItemWeight = safeValue(knapSack: knapSack, row: index_item - 1, column: index_weight - item.weight)
            let optimumValueWithCurrentItemWeight =
                (optimumValueWithoutCurrentItemWeight == nil) ? 0 :  (optimumValueWithoutCurrentItemWeight! + item.value)
           
            let currentOptimumValue = max(lastKnownOptimumValue, optimumValueWithCurrentItemWeight)
            knapSack[index_item][index_weight] = currentOptimumValue
        }
    }
    
    /// For debug purpose
    print("Knapsack optimum chart: ")
    knapSack.forEach { row in print(row) }
    
    var selectedItems: [Item] = []
    var i = items.count, j = targetWeight
    while i > 0, j > 0 {
        if knapSack[i][j] == knapSack[i-1][j] {
            i -= 1
        } else {
            let item = items[i-1]
            selectedItems.append(item)
            j = j - item.weight
        }
    }
    
    print("Items selected:")
    print(selectedItems)
    
    return knapSack[items.count][targetWeight]
}

func safeValue(knapSack: [[Int]], row: Int, column: Int) -> Int? {
    if row >= 0, row < knapSack.count, let singleRow = knapSack.first,
        column >= 0, column < singleRow.count {
        return knapSack[row][column]
    }
    return nil
}


// Driver function.
func main() {
    print("Demonstration of 0/1 knapsack problem.")
    print("More information can be found at:")
    print("https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/")
    
    let items = [
        Item(weight: 1, value: 1),
        Item(weight: 3, value: 4),
        Item(weight: 4, value: 5),
        Item(weight: 5, value: 7)
    ]

    print("Weight   Value")
    for item in items {
        print("\(item.weight) \t \(item.value)")
    }
    
    let targetWeight = 7
    print("The knap sacked optimum value for target weight \(targetWeight) is \(knapSack01(items: items, targetWeight: targetWeight))")
}

main()
