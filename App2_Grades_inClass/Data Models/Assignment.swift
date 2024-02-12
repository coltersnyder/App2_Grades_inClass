//
//  Assignment.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation

class Assignment: Identifiable {
    let id = Assignment.ID()
    
    let name: String
    
    var maxScore: Double
    
    let assignmentGroup: AssignmentGroup
    
    var scores: [AssignmentScore.ID: AssignmentScore] = [:]
    
    init(name: String, maxScore: Double, assignmentGroup: AssignmentGroup) {
        self.name = name
        self.maxScore = maxScore
        self.assignmentGroup = assignmentGroup
    }
    
    struct ID: Identifiable, Hashable {
        var id = UUID()
    }
}
