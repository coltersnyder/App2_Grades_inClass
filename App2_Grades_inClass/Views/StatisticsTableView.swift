//
//  StatisticsTableView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/23/24.
//

import SwiftUI

struct StatisticsAssignmentTableView: View {
    @EnvironmentObject var gradesViewModel: GradesViewModel
    var assignments: [Assignment]
    
    @Binding var sortOrder: [KeyPathComparator<Assignment>]
    
    var body: some View {
        Table(assignments, sortOrder: $sortOrder) {
            TableColumn("Assignment Name", value: \.name)
            TableColumn("Assignment Mean") {
                Text(String(format: "%.1f", gradesViewModel.courseResults.statistics.assignmentMeans[$0.id] ?? 0.0))
            }
            TableColumn("Assignment Median") {
                Text(String(format: "%.1f", gradesViewModel.courseResults.statistics.assignmentMedians[$0.id] ?? 0.0))
            }
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
    }
}

struct StatisticsGroupTableView: View {
    @EnvironmentObject var gradesViewModel: GradesViewModel
    var groups: [AssignmentGroup]
    
    @Binding var sortOrder: [KeyPathComparator<AssignmentGroup>]
    
    var body: some View {
        Table(groups, sortOrder: $sortOrder) {
            TableColumn("Assignment Group Name", value: \.name)
            TableColumn("Assignment Group Mean") {
                Text(String(format: "%.1f", gradesViewModel.courseResults.statistics.assignmentGroupMeans[$0.id] ?? 0.0))
            }
            TableColumn("Assignment Group Median") {
                Text(String(format: "%.1f", gradesViewModel.courseResults.statistics.assignmentGroupMedians[$0.id] ?? 0.0))
            }
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
    }
}
