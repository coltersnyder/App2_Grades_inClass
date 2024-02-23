//
//  AssignmentGroupTableView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/22/24.
//

import SwiftUI

struct AssignmentGroupTableView: View {
    var assignmentGroups: [AssignmentGroup]
    
    @Binding var sortOrder: [KeyPathComparator<AssignmentGroup>]
    
    var body: some View {
        Table(assignmentGroups, sortOrder: $sortOrder) {
            TableColumn("Assignment Group Name", value: \.name)
            TableColumn("Assignment Group Weight", value: \.weight) {
                Text(String(format: "%.2f", $0.weight))
            }
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
    }
}
