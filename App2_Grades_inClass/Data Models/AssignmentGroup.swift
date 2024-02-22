//
//  AssignmentGroup.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation

class AssignmentGroup: Identifiable {
    let id = AssignmentGroup.ID()
    
    var name: String
    
    var weight: Double
    
    var assignments: [Assignment.ID: Assignment] = [:]
    
    var maxPointsInGroup: Double {
        get {
            updateMax()
        }
    }
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    struct ID: Identifiable, Hashable {
        var id = UUID()
    }
    
    private func updateMax() -> Double{
        var runningTotal = 0.0
        
        for item in self.assignments.values {
            runningTotal += item.maxScore
        }
        
        return runningTotal
    }
}

extension AssignmentGroup: Equatable {
    
    static func == (lhs: AssignmentGroup, rhs: AssignmentGroup) -> Bool {
        if lhs.name == rhs.name && lhs.weight == rhs.weight {
            return true
        } else {
            return false
        }
    }
    
}
