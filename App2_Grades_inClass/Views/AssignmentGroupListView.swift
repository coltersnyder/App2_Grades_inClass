//
//  AssignmentGroupListView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/22/24.
//

import SwiftUI

struct AssignmentGroupListView: View {
    @EnvironmentObject var gradeViewModel: GradesViewModel
    @Binding var assignmentGroups: [AssignmentGroup]
    
    let formatter = NumberFormatter()
    
    var body: some View {
        List($assignmentGroups) { $nextGroup in
            HStack {
                Text(nextGroup.name)
                Spacer()
                Text("Weight:")
                TextField("Weight", value: $nextGroup.weight, formatter: formatter, onCommit: gradeViewModel.updateGroupState)
            }
        }
    }
}
