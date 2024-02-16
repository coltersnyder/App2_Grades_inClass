//
//  App2_Grades_inClassApp.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/7/24.
//

import SwiftUI

@main
struct App2_Grades_inClassApp: App {
    @StateObject var gradeViewModel = GradesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gradeViewModel)
        }
    }
}
