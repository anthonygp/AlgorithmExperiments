//
//  main.swift
//  TravellingSalesManHeldKarp
//
//  Created by Anthony Gonsalves on 11.10.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation


func generatePowerSet(n: Int) -> [Set<Int>] {
    var result: [Set<Int>] = [[]]

    for i in 1..<n {
        var newSet: [Set<Int>] = []
        for set in result {
            var lastSet = set
            lastSet.insert(i)
            newSet.append(lastSet)
        }
        result.append(contentsOf: newSet)
    }
    return result.sorted { $0.count < $1.count }
}


struct PathInfo: Hashable, CustomStringConvertible {
    var vertex: Int = 0
    var others: Set<Int> = []
    
    var description: String {
        "vertex:\(vertex) edges:{\(others)} "
    }
}



func travellingSalesMan(cityCost: [[Int]]) -> Int {
    var minCost: [PathInfo: Int] = [:]
    var path: [PathInfo: Int] = [:]
    let combinationOfVertices = generatePowerSet(n: cityCost.count)
    
    // Insert the seed.
    for currentVertex in stride(from: 0, to: cityCost.count, by: 1) {
        minCost[PathInfo(vertex: currentVertex, others: [])] = cityCost[0][currentVertex]
    }
    
    for vertexSet in combinationOfVertices {
        for currentVertex in stride(from: 0, to: cityCost.count, by: 1) {
            if vertexSet.contains(currentVertex) {
                continue
            }

            var minCostToReachCurrentVertex = 100000
            var minPreviousVertex = 0
            
            if vertexSet.count == 0 {
                minCostToReachCurrentVertex = cityCost[0][currentVertex]
            } else {
                for previousVertex in vertexSet {
                    let minCostToReachPreviousVertex = costExludingVertex(previousVertex, vertexSet: vertexSet, minCost: minCost)
                    let cost = cityCost[previousVertex][currentVertex] + minCostToReachPreviousVertex
                    if cost < minCostToReachCurrentVertex {
                        minCostToReachCurrentVertex = cost
                        minPreviousVertex = previousVertex
                    }
                }
            }
            
            let pathInfo = PathInfo(vertex: currentVertex, others: vertexSet)
            minCost[pathInfo] = minCostToReachCurrentVertex
            path[pathInfo] = minPreviousVertex
        }
    }
    
    /**
    var lastPathInfo: PathInfo? = PathInfo(vertex: 0, others: [1, 2, 3])
    while let pathInfo = lastPathInfo, pathInfo.others.count != 0 {
        let parentVertex = path[pathInfo]
        lastPathInfo = path.first(where: { currentPathInfo, value -> Bool in
            if currentPathInfo.vertex == parentVertex {
                return true
            }
            return false
        })?.key
        print(parentVertex)
    }
    */
    
    
    print(minCost)
    print(path)
    
    return 0
}

func costExludingVertex(_ vertex: Int, vertexSet: Set<Int>, minCost: [PathInfo: Int]) -> Int {
     var setExludingCurrentVertex = vertexSet
    setExludingCurrentVertex.remove(vertex)
    return minCost[PathInfo(vertex: vertex, others: setExludingCurrentVertex)] ?? 0
}


/// Driver function
func main() {
    let cityCost =
    [
        [0, 1,  15, 6],
        [2, 0,  7,  3],
        [9, 6,  0,  12],
        [10, 4, 8,  0]
    ]
    
    print("Demonstation of travelling sales man problem.")
    print("Input energy cost:\n\(cityCost)")
    print("\(travellingSalesMan(cityCost: cityCost))")
}

main()
