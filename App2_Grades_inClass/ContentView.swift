//
//  ContentView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gradesViewModel: GradesViewModel
    
    var body: some View {
        VSplitView {
            DropFileView(url: $gradesViewModel.url)
                .frame(minHeight: 50.0)
                .padding(.horizontal)
            HSplitView {
                AssignmentGroupTableView(assignmentGroups: gradesViewModel.assignmentGroups, sortOrder: $gradesViewModel.groupSortOrder)
                AssignmentGroupListView(assignmentGroups: $gradesViewModel.assignmentGroups)
            }
            HSplitView {
                StudentTableView(students: gradesViewModel.students, sortOrder: $gradesViewModel.sortOrder)
                StudentsListView(students: $gradesViewModel.students)
            }
        }
    }
    
    @ViewBuilder
    func startingView() -> some View {
        VSplitView {
            Text("Drop View")
                .frame(maxWidth: .infinity, minHeight: 75, maxHeight: 100)
            HSplitView {
                Text("Table")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                Text("List")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            }
        }
        .padding()
    }
}
