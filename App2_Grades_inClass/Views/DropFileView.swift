//
//  DropFileView.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/14/24.
//

import SwiftUI

struct DropFileView: View {
    @Binding var url: URL?
    
    @State var isHoveredOver = false
    
    var body: some View {
        let dropDelegate = CSVURLDropDelegate(url: $url, isHoveredOver: $isHoveredOver)
        
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .strokeBorder(.gray, lineWidth: 2.0)
            Text(fileName())
        }
        .onDrop(of: [.url], delegate: dropDelegate)
    }
    
    func fileName() -> String {
        if let url = url {
            return url.lastPathComponent
        } else {
            return "Drop File Here"
        }
    }
}
