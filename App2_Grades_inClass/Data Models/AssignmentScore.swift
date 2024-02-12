//
//  AssignmentScore.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation

class AssignmentScore: Identifiable {
    let id = AssignmentScore.ID()
    
    let studentID: Student.ID
    
    let assignmentID: Assignment.ID
    
    var score: Double
    
    init(studentID: Student.ID, assignmentID: Assignment.ID, score: Double) {
        self.studentID = studentID
        self.assignmentID = assignmentID
        self.score = score
    }
    
    struct ID: Identifiable, Hashable {
        var id = UUID()
    }
    
}
