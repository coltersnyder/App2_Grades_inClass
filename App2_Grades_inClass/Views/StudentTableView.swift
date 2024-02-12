//
//  StudentTableView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import SwiftUI

struct StudentTableView: View {
    var students: [Student]
    
    @Binding var sortOrder: [KeyPathComparator<Student>]
    
    var body: some View {
        Table(students, sortOrder: $sortOrder) {
            TableColumn("Student Name", value: \.name)
            TableColumn("Student ID", value: \.studentID)
            TableColumn("Student Score", value: \.overallScore) {
                Text(String(format: "%.2f", $0.overallScore))
            }
            TableColumn("Letter Grade", value: \.letterGrade) {
                Text($0.letterGrade.rawValue)
            }
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}
