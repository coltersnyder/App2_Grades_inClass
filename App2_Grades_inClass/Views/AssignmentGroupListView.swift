//
//  AssignmentGroupListView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/22/24.
//

import SwiftUI

struct AssignmentGroupListView: View {
    @Binding var assignmentGroups: [AssignmentGroup]
    
    var body: some View {
        List($assignmentGroups) { $nextGroup in
            HStack {
                Text(nextGroup.name)
                Spacer()
                Text("Weight:")
                TextField("Weight", value: $nextGroup.weight, format: .number)
            }
        }
    }
}
