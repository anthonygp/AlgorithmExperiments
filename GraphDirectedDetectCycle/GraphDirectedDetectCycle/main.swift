//
//  main.swift
//  GraphDirectedDetectCycle
//
//  Created by Anthony Gonsalves on 14.10.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/**
 please refer https://www.youtube.com/watch?v=rKQaZuoUR4M&t=158s
 We maintain 3 types of set
 1. All non visited Vertex set.
 2. Vertex set under inspection.
 3. Vertex set that is having non cyclic vertex set.
 
 The logic is very simple.
 1. Take any random vertex which will be our vertex under observation, take out from
    the nonVisited set and put it under-inspection set. Perform dfs on the vertex.
 2. Take the vertex that is currently being inspected and move it from the nonVisited set and put it under
    vertexUnder inspection set.
 3. Perform dfs vertex.
 3. Take the children of th vertex under observation and check whether those are in  under-inspection set. If yes we
    have found a cycle. If not we perform step 3 on each child vertex.
 4. Move the vertex under inspection from `under-inspection set` to `non-cyclic vertex set`.
 5. Repeat step 1 untill there are no elements in `non-visited` set and all have been moved to `non-cyclic vertex set`.
 */
/// Returns true if the graph is having a cycle.
func hasCycle<T>(graph: Graph<T>) -> Bool {
    typealias VertexInfo = Graph<T>.VertexInfo
    var underInspectionVertexSet: Set<VertexInfo> = []
    var nonCyclicVertexSet: Set<VertexInfo> = []
    
    // Begin with adding all the vertex set to this nonVisitedVertexSet.
    var nonVisitedVertexSet = Set(graph.vertices)
    
    while nonVisitedVertexSet.isEmpty == false {
        if let visitingVertex = nonVisitedVertexSet.first { // Picking any vertex from the set.
            let isVertexHavingCycle = performDFSForCycleCheck(on: visitingVertex,
                                                             nonVisitedVertexSet: &nonVisitedVertexSet,
                                                             underInspectionSet: &underInspectionVertexSet,
                                                             nonCyclicVertexSet: &nonCyclicVertexSet)
            if isVertexHavingCycle {
                return true
            }
        }
    }
    
    return false
}

/// Performs the dfs on the vertex and systematically moves the vertices from `nonVisitedVertexSet` to
/// `underInspectionSet`
/// - Parameters:
///   - vertex: Vertex information.
///   - nonVisitedVertexSet: All non visited Vertex set.
///   - underInspectionSet: Vertex set under inspection.
///   - nonCyclicVertexSet: Vertex set that is having non cyclic vertex set.
/// - Returns: true if we found a cycle.
func performDFSForCycleCheck<T>(on vertex: Graph<T>.VertexInfo,
                                nonVisitedVertexSet: inout Set<Graph<T>.VertexInfo>,
                                underInspectionSet: inout Set<Graph<T>.VertexInfo>,
                                nonCyclicVertexSet: inout Set<Graph<T>.VertexInfo>) -> Bool {
    move(element: vertex, fromSet: &nonVisitedVertexSet, toSet: &underInspectionSet)
    for childVertex in vertex.connectedEdges {
        // This should not happen. Under inspection set contains all those vertices those are currently being checked
        // for cycle. If we encounter a vertex more than once(i.e if we find the child vertex already
        // in `underInspectionSet`) then we have found a cycle and we return false
        if underInspectionSet.contains(childVertex) {
            return true
        }
        // Perform dfs again on the child vertex and move the child vertex from the `nonVisitedVertexSet` to
        // `underInspectionSet`
        let isVertexHavingCycle = performDFSForCycleCheck(on: childVertex,
                                                          nonVisitedVertexSet: &nonVisitedVertexSet,
                                                          underInspectionSet: &underInspectionSet,
                                                          nonCyclicVertexSet: &nonCyclicVertexSet)
        if isVertexHavingCycle == true {
            return true
        }
    }
    // We have inspected all the children vertices. Now we move the vertex under observation from `inspection set` to
    // the `non cyclic vertex set`.
    move(element: vertex, fromSet: &underInspectionSet, toSet: &nonCyclicVertexSet)
    return false
}

func move<T>(element: T, fromSet: inout Set<T>, toSet: inout Set<T>) {
    fromSet.remove(element)
    toSet.insert(element)
}

// This is just a convienence data structure. Don't bother much on this.
class Graph<T: Hashable> {
    class VertexInfo: Hashable {
        static func == (lhs: VertexInfo, rhs: VertexInfo) -> Bool {
            if lhs.name == rhs.name, lhs.connectedEdges == rhs.connectedEdges {
                return true
            }
            return false
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(Set(connectedEdges.map { $0.name}))
        }
        
        let name: T
        // We assume the graph to be directed
        var connectedEdges: [VertexInfo] = []
        
        init(name: T) {
            self.name = name
        }
    }
    
    let vertices: [VertexInfo]
    
    init(vertices: [T]) {
        self.vertices = vertices.map { VertexInfo(name: $0)}
    }
    
    init(vertices: [VertexInfo]) {
        self.vertices = vertices
    }
}

/// Driver function
func main() {
    typealias VertexInfo = Graph<String>.VertexInfo
    let vertexInfoA = VertexInfo(name: "A")
    let vertexInfoB = VertexInfo(name: "B")
    let vertexInfoC = VertexInfo(name: "C")
    
    vertexInfoA.connectedEdges = [vertexInfoB]
    vertexInfoB.connectedEdges = [vertexInfoC]
    vertexInfoC.connectedEdges = [vertexInfoA]

    // A -> B -> C -> A, this is a cyclic graph.
    let graph = Graph<String>(vertices: [vertexInfoA, vertexInfoB, vertexInfoC])
    print("Is this a cyclic graph: \(hasCycle(graph: graph))")
    
    vertexInfoC.connectedEdges = []
    // A -> B -> C, this is a not a cyclic graph.
    print("Is this a cyclic graph: \(hasCycle(graph: graph))")
}

// Drive
main()
