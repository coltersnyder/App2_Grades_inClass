//
//  ParsedData.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/22/24.
//

import Foundation

struct ParsedData {
    var AssignmentGroups: [AssignmentGroup]
    var Assignments: [Assignment]
    var Students: [Student]
    var AssignmentScores: [AssignmentScore]
    
    func syncData() {
        // Take in a student id, output a dictionary that takes an assignment group id, output the running total for that category
        var calcIntermediate: [Student.ID: [AssignmentGroup.ID: Double]] = [:]
        
        for assignmentScore in AssignmentScores {
            if let assignmentGroup = AssignmentGroups.first(where: { $0.assignments[assignmentScore.assignmentID] != nil } ) {
                if calcIntermediate[assignmentScore.studentID] == nil {
                    calcIntermediate[assignmentScore.studentID] = [assignmentGroup.id: 0.0]
                }
                
                if calcIntermediate[assignmentScore.studentID]?[assignmentGroup.id] == nil {
                    calcIntermediate[assignmentScore.studentID]?[assignmentGroup.id] = 0.0
                }
                
                calcIntermediate[assignmentScore.studentID]?[assignmentGroup.id]? += assignmentScore.score
            }
        }
        
        for student in Students {
            var finalScore: Double = 0.0
            
            var groupTotalWeight = 0.0
            
            for assignmentScore in AssignmentScores {
                if assignmentScore.studentID == student.id {
                    student.assignmentGrades[assignmentScore.assignmentID] = assignmentScore.score
                }
            }
            
            for assignmentGroup in AssignmentGroups {
                if let score = calcIntermediate[student.id]?[assignmentGroup.id] {
                    student.groupGrades[assignmentGroup.id] = score
                    finalScore += (((score / assignmentGroup.maxPointsInGroup) * 100) * (assignmentGroup.weight / 100))
                }
                
                groupTotalWeight += assignmentGroup.weight
            }
            
            student.overallScore = (finalScore * (groupTotalWeight / 100))
        }
    }
}
