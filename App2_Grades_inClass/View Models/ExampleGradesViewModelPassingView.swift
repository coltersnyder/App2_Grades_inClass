//
//  ExampleGradesViewModelPassingView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/16/24.
//

import SwiftUI

struct ExampleGradesViewModelPassingView: View {
    @EnvironmentObject var gradesViewModel: GradesViewModel
    
    var body: some View {
        List() {
            ForEach($gradesViewModel.students) { $nextStudent in
                TextField("Name", text: $nextStudent.name)
            }
        }
    }
}
