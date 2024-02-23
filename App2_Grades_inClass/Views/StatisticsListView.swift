//
//  StatisticsListView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/23/24.
//

import SwiftUI

struct StatisticsListView: View {
    @EnvironmentObject var gradesViewModel: GradesViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Overall Mean:")
                Spacer()
                Text(String(format: "%.1f", gradesViewModel.courseResults.statistics.overallMean))
            }
            HStack {
                Text("Overall Median:")
                Spacer()
                Text(String(format: "%.1f", gradesViewModel.courseResults.statistics.overallMedian))
            }
        }
    }
}
