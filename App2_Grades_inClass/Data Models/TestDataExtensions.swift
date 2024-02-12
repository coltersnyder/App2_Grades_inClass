//
//  TestDataExtensions.swift
//  Grades
//
//  Created by Owen Hildreth on 2/17/22.
//

import Foundation


// MARK: - Course Results Test Data
extension CourseResults {
    
    convenience init(withTestData: Bool = true) {
        if !withTestData {self.init()}
        else {
            self.init()
            self.students = self.createTestStudents()
            self.assignmentGroups = self.createTestAssignmentGroups()
        }
    }
    
    func createTestStudents() -> [Student.ID : Student] {
        let students = [ Student(name: "Bob", studentID: "123", overallScore: 10.0),
                                Student(name: "John", studentID: "234", overallScore: 60.0),
                                Student(name: "Jane", studentID: "345", overallScore: 85),
                                Student(name: "Courtney", studentID: "456", overallScore: 100.0)
        ]
        
        var studentsDict: [Student.ID : Student] = [:]
        
        for nextStudent in students {
            studentsDict[nextStudent.id] = nextStudent
        }
        
        return studentsDict
    }
    
    func createTestAssignmentGroups() -> [AssignmentGroup.ID : AssignmentGroup] {
        var groups: [AssignmentGroup.ID : AssignmentGroup] = [:]
        let localStudents = Array(self.students.values)
        
        for index in 1...4 {
            let newGroup = AssignmentGroup(name: "Group \(index)", weight: 25.0)
            newGroup.createTestAssignments(forStudents: localStudents)
            
            groups[newGroup.id] =  newGroup
        }
        
        return groups
    }
}




// MARK: - Assignment Test Data
extension Assignment {
    func createTestScores(forStudents students: [Student]) {
        for nextStudent in students {
            let score = Double.random(in: 0...100)
            
            let newScore = AssignmentScore(studentID: nextStudent.id, assignmentID: self.id, score: score)
            
            self.scores[nextStudent.id] = newScore
        }
    }
}



// MARK: - Assignment Group Test Data
extension AssignmentGroup {
    func createTestAssignments(forStudents students: [Student]) {
        var localAssignments: [Assignment] = []
        
        for index in 1...4 {
            let newAssignment = Assignment(name: "Assignment \(index)", group: self, maxScore: 10)
            
            newAssignment.createTestScores(forStudents: students)
            
            localAssignments.append(newAssignment)
            
            assignments[newAssignment.id] = newAssignment
        }
    }
}

