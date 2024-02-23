//
//  CourseResults.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation
import SwiftUI

class CourseResults: ObservableObject {
    var students: [Student.ID: Student] = [:]  {
        didSet {
            NotificationCenter.default.post(name: .studentsDidChange, object: self)
        }
    }
    
    var assignmentGroups: [AssignmentGroup.ID: AssignmentGroup] = [:] {
        didSet {
            NotificationCenter.default.post(name: .groupsDidChange, object: self)
        }
    }
    
    var assignments: [Assignment.ID: Assignment] = [:]
    
    var statistics: AssignmentStatistics {
        get {
            calculateStatistics()
        }
    }
    
    struct AssignmentStatistics {
        var assignmentMeans: [Assignment.ID: Double]
        var assignmentMedians: [Assignment.ID: Double]
        var overallMean: Double
        var overallMedian: Double
        var assignmentGroupMeans: [AssignmentGroup.ID: Double]
        var assignmentGroupMedians: [AssignmentGroup.ID: Double]
    }
    
    func calculateStatistics() -> AssignmentStatistics {
        var assignmentMeans: [Assignment.ID: Double] = [:]
        var assignmentMedians: [Assignment.ID: Double] = [:]
        var overallMean: Double = 0.0
        var overallMedian: Double = 0.0
        var assignmentGroupMeans: [AssignmentGroup.ID: Double] = [:]
        var assignmentGroupMedians: [AssignmentGroup.ID: Double] = [:]
        
        var tempScoreStore: [Assignment.ID: [Double]] = [:]
        var tempGroupScoreStore: [AssignmentGroup.ID: [Double]] = [:]
        
        let numberOfStudents: Double = Double(students.count)
        var studentOverallScores: [Double] = []
        
        for student in students.values {
            for (assignID, score) in student.assignmentGrades {
                if assignmentMeans[assignID] == nil {
                    assignmentMeans[assignID] = 0.0
                }
                
                if tempScoreStore[assignID] == nil {
                    tempScoreStore[assignID] = []
                }
                
                assignmentMeans[assignID]? += score
                tempScoreStore[assignID]?.append(score)
            }
            
            overallMean += student.overallScore
            studentOverallScores.append(student.overallScore)
            
            for (groupID, score) in student.groupGrades {
                if assignmentGroupMeans[groupID] == nil {
                    assignmentGroupMeans[groupID] = 0.0
                }
                
                if tempGroupScoreStore[groupID] == nil {
                    tempGroupScoreStore[groupID] = []
                }
                
                assignmentGroupMeans[groupID]? += score
                tempGroupScoreStore[groupID]?.append(score)
            }
        }
        
        overallMean /= numberOfStudents
        studentOverallScores.sort()
        overallMedian = studentOverallScores[Int(floor(numberOfStudents / 2))]
        
        for (assignID, scores) in tempScoreStore {
            let index: Int = scores.count / 2
            if let median = tempScoreStore[assignID]?[index] {
                assignmentMedians[assignID] = median
            } else {
                assignmentMedians[assignID] = 0.0
            }
        }
        
        for (assignID, _) in assignmentMeans {
            assignmentMeans[assignID]? /= Double(numberOfStudents)
            tempScoreStore[assignID]?.sort()
            if let store = tempScoreStore[assignID] {
                assignmentMedians[assignID] = store[Int(numberOfStudents / 2.0)]
            }
        }
        
        for (groupID, _) in assignmentGroupMeans {
            assignmentGroupMeans[groupID]? /= Double(numberOfStudents)
            tempGroupScoreStore[groupID]?.sort()
            if let store = tempGroupScoreStore[groupID] {
                assignmentGroupMedians[groupID] = store[Int(numberOfStudents / 2.0)]
            }
        }
        
        return AssignmentStatistics(assignmentMeans: assignmentMeans, assignmentMedians: assignmentMedians, overallMean: overallMean, overallMedian: overallMedian, assignmentGroupMeans: assignmentGroupMeans, assignmentGroupMedians: assignmentGroupMedians)
    }
    
    
}
