//
//  main.swift
//  TopologicalSort
//
//  Created by Anthony Gonsalves on 25.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

class Graph {
    class VertexInfo {
        let name: String
        // We assume the graph to be directed
        var connectedEdges: [VertexInfo] = []
        
        init(name: String) {
            self.name = name
        }
    }
    
    let vertices: [VertexInfo]
    
    init(vertices: [String]) {
        self.vertices = vertices.map { VertexInfo(name: $0)}
    }
    
    init(vertices: [VertexInfo]) {
        self.vertices = vertices
    }
}

extension Array {
    mutating func push(element: Element) { append(element) }
    mutating func pop() -> Element? { popLast() }
}

func startTracing(graph: Graph) -> [String] {
    var graphStack: [String] = []
    var visited: [String] = []
    for vertexInfo in graph.vertices {
        topological(graph: graph, vertex: vertexInfo,
                    visited: &visited, graphStack: &graphStack)
    }
    return graphStack
}

/**
 We perform dfs on each of the node and mark any node we trace along the way as visited
 then when land on a child/node that has no path the other non visited node we add to the
 stack. At the end, we empty all the stack which represents the topological order. This
 algorithm is primarily used in build system.
 */
func topological(graph: Graph, vertex: Graph.VertexInfo,
                 visited: inout [String], graphStack: inout [String]) {
    if visited.contains(vertex.name) {
        return
    }
    visited.append(vertex.name)
    
    for edge in vertex.connectedEdges {
        if visited.contains(edge.name) == false {
            topological(graph: graph, vertex: vertex, visited: &visited, graphStack: &graphStack)
        }
    }
    graphStack.push(element: vertex.name)
}

/// Driver function
func main() {
    print("Demonstration of Topological Sort")
    print("Find more details at ")
    print("https://leetcode.com/problems/sort-items-by-groups-respecting-dependencies/discuss/389805/JAVA-Topological-sort.-Detailed-Explanation")
    print("https://www.youtube.com/watch?v=ddTC4Zovtbc")
    
    let vertexInfoA = Graph.VertexInfo(name: "A")
    let vertexInfoB = Graph.VertexInfo(name: "B")
    let vertexInfoC = Graph.VertexInfo(name: "C")
    let vertexInfoD = Graph.VertexInfo(name: "D")
    let vertexInfoE = Graph.VertexInfo(name: "E")
    let vertexInfoF = Graph.VertexInfo(name: "F")
    let vertexInfoG = Graph.VertexInfo(name: "G")
    
    vertexInfoA.connectedEdges = [vertexInfoC]
    vertexInfoB.connectedEdges = [vertexInfoC, vertexInfoE]
    vertexInfoC.connectedEdges = [vertexInfoD]
    vertexInfoD.connectedEdges = [vertexInfoF]
    vertexInfoE.connectedEdges = [vertexInfoF]
    vertexInfoF.connectedEdges = [vertexInfoG]
    let vertices = [vertexInfoA, vertexInfoB, vertexInfoC,
                    vertexInfoD, vertexInfoE, vertexInfoF, vertexInfoG]
    
    print("The topologically sorted order is: ")
    print("\(startTracing(graph: Graph(vertices: vertices)))")
}

/// Drive
main()
