//
//  ContentView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        startingView()
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

#Preview {
    ContentView()
}
