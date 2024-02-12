//
//  CourseResults.swift
//  App2_Grades_inClass
//
//  Created by Colter Snyder on 2/9/24.
//

import Foundation
import SwiftUI

class CourseResults: ObservableObject {
    var students: [Student.ID: Student] = [:]
    
    var assignmentGroups: [AssignmentGroup.ID: AssignmentGroup] = [:]
}
