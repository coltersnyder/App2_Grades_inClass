//
//  Student.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation

class Student: Identifiable {
    let id = Student.ID()
    
    let studentID: String
    
    var name: String
    
    var overallScore: Double = 0.0
    
    var letterGrade: LetterGrade {
        get {
            LetterGrade(withScore: overallScore)
        }
    }
    
    init(name: String, studentID: String) {
        self.name = name
        self.studentID = studentID
    }
    
    convenience init(name: String, studentID: String, overallScore: Double) {
        self.init(name: name, studentID: studentID)
        
        self.overallScore = overallScore
    }
    
    struct ID: Identifiable, Hashable {
        var id = UUID()
    }
}
