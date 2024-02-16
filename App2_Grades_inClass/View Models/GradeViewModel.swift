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
            print("New URL: \(String(describing: url))")
        }
    }
    
    @Published var students: [Student] = []
    
    @Published var sortOrder: [KeyPathComparator<Student>] = [
        .init(\.name, order: .forward)
    ] {
        didSet {
            updateState()
        }
    }
    
    func updateState() {
        self.students = Array(courseResults.students.values).sorted(using: sortOrder)
    }
    
    init() {
        setNotifications()
        updateState()
    }
    
    private func setNotifications() {
        NotificationCenter.default.addObserver(forName: .studentsDidChange, 
                                               object: nil,
                                               queue: nil,
                                               using: studentStateDidChange)
    }
    
    private func studentStateDidChange(_ notification: Notification) {
        self.updateState()
    }
}


extension Notification.Name {
    static let studentsDidChange = Notification.Name("studentsDidChange")
}
