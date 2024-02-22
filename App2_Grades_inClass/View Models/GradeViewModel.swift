//
//  GradeViewModel.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation
import SwiftUI

class GradesViewModel: ObservableObject {
    var courseResults = CourseResults(withTestData: true)
    
    @Published var url: URL? = nil {
        didSet {
            // TODO: create and call parse file to update State
            let fileParser = FileParser(url: url)
            let parsedData = fileParser.parseFile()
            parsedData?.syncData()
            if let studs = parsedData?.Students {
                students = studs
                courseResults.students = [:]
                for student in studs {
                    courseResults.students[student.id] = student
                }
            }
            if let groups = parsedData?.AssignmentGroups {
                assignmentGroups = groups
                courseResults.assignmentGroups = [:]
                for assignmentGroup in groups {
                    courseResults.assignmentGroups[assignmentGroup.id] = assignmentGroup
                }
            }
            
            print("New URL: \(String(describing: url))")
        }
    }
    
    @Published var students: [Student] = []
    
    @Published var assignmentGroups: [AssignmentGroup] = []
    
    @Published var sortOrder: [KeyPathComparator<Student>] = [
        .init(\.name, order: .forward)
    ] {
        didSet {
            updateState()
        }
    }
    
    @Published var groupSortOrder: [KeyPathComparator<AssignmentGroup>] = [
        .init(\.name, order: .forward)
    ] {
        didSet {
            updateGroupState()
        }
    }
    
    func updateState() {
        self.students = Array(courseResults.students.values).sorted(using: sortOrder)
    }
    
    func updateGroupState() {
        self.assignmentGroups = Array(courseResults.assignmentGroups.values).sorted(using: groupSortOrder)
    }
    
    init() {
        setNotifications()
        updateState()
        updateGroupState()
    }
    
    private func setNotifications() {
        NotificationCenter.default.addObserver(forName: .studentsDidChange, 
                                               object: nil,
                                               queue: nil,
                                               using: studentStateDidChange)
        NotificationCenter.default.addObserver(forName: .groupsDidChange,
                                               object: nil,
                                               queue: nil,
                                               using: groupStateDidChange)
    }
    
    private func studentStateDidChange(_ notification: Notification) {
        self.updateState()
    }
    
    private func groupStateDidChange(_ notification: Notification) {
        self.updateGroupState()
    }
}


extension Notification.Name {
    static let studentsDidChange = Notification.Name("studentsDidChange")
    static let groupsDidChange = Notification.Name("groupsDidChange")
}
