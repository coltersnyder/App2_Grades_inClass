//
//  ParseFile.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/21/24.
//

import Foundation

class FileParser {
    let url: URL?
    
    var assignmentGroups: [AssignmentGroup] = []
    var colToAssignGroup: [Int: AssignmentGroup] = [:]
    var students: [Student] = []
    var rowToStud: [Int: Student] = [:]
    var assignments: [Assignment] = []
    var colToAssign: [Int: Assignment] = [:]
    var assignmentScores: [AssignmentScore] = []
    var studentScores: [Student.ID: [AssignmentScore]] = [:]
    
    init(url: URL?) {
        self.url = url
    }
    
    func parseFile() -> ParsedData? {
        var csvContents: [[String]] = []
        var finalData: ParsedData
        
        do {
            if let url {
                let path = url.path().replacing("%20", with: " ")
                
                let content = try String(contentsOfFile: path).replacingOccurrences(of: "\r", with: "")
                let csvLines = content.components(separatedBy: "\n")
                for line in csvLines {
                    csvContents.append(line.components(separatedBy: ","))
                }
            } else {
                print("Failed to Parse URL")
                return nil
            }
        } catch {
            print("Failed to Open File")
            print(error)
            return nil
        }
        
        if csvContents.count < 4 {
            print("Unable to Parse File")
            return nil
        }
        
        for (rowID, row) in csvContents.enumerated() {
            for (columnID, column) in row.enumerated() {
                switch rowID {
                case 0:
                    if column != "" {
                        var assignGroup: AssignmentGroup
                        if let weight = Double(csvContents[1][columnID]) {
                            assignGroup = AssignmentGroup(name: column, weight: weight)
                        } else {
                            assignGroup = AssignmentGroup(name: column, weight: 0.0)
                        }
                        
                        if !assignmentGroups.contains(assignGroup) {
                            assignmentGroups.append(assignGroup)
                            colToAssignGroup[columnID] = assignGroup
                        } else {
                            if let group = assignmentGroups.first(where: { $0 == assignGroup} ) {
                                colToAssignGroup[columnID] = group
                            }
                        }
                    }
                    
                case 1:
                    break
                    
                case 2:
                    if column != "" {
                        if let assignGroup = colToAssignGroup[columnID] {
                            var assign: Assignment
                            
                            if let score = Double(csvContents[3][columnID]) {
                                assign = Assignment(name: column, maxScore: score, assignmentGroup: assignGroup)
                            } else {
                                assign = Assignment(name: column, maxScore: 0.0, assignmentGroup: assignGroup)
                            }
                            
                            assignGroup.assignments[assign.id] = assign
                            assignments.append(assign)
                            colToAssign[columnID] = assign
                        }
                        
                    }
                    
                case 3:
                    break
                    
                default:
                    switch columnID {
                    case 0:
                        if column != "" {
                            let student = Student(name: column, studentID: csvContents[rowID][1])
                            students.append(student)
                            rowToStud[rowID] = student
                        }
                        
                    case 1:
                        break
                        
                    default:
                        var score: AssignmentScore
                        if let student = rowToStud[rowID], let thisAssignment = colToAssign[columnID] {
                            if let points = Double(column) {
                                score = AssignmentScore(studentID: student.id, assignmentID: thisAssignment.id, score: points)
                            } else {
                                score = AssignmentScore(studentID: student.id, assignmentID: thisAssignment.id, score: 0.0)
                            }
                            
                            assignmentScores.append(score)
                            if studentScores[student.id] == nil {
                                studentScores[student.id] = []
                            }
                            studentScores[student.id]?.append(score)
                        }
                    }
                }
            }
        }
        
        finalData = ParsedData(AssignmentGroups: assignmentGroups, Assignments: assignments, Students: students, AssignmentScores: assignmentScores)
        
        return finalData
    }
    
}
