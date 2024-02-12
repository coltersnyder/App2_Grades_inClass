//
//  Student.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation

class Student: Identifiable {
    let id = UUID()
    
    let studentID: String
    
    var name: String
    
    var overAllScore: Double = 0.0
    
    var letterGrade: LetterGrade {
        get {
            LetterGrade(withScore: overAllScore)
        }
    }
    
    init(name: String, studentID: String) {
        self.name = name
        self.studentID = studentID
    }
    
    convenience init(name: String, studentID: String, overAllScore: Double) {
        self.init(name: name, studentID: studentID)
        
        self.overAllScore = overAllScore
    }
}
