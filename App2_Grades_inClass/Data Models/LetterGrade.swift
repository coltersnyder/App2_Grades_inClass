//
//  LetterGrade.swift
//  HW03_solution
//
//  Created by Owen Hildreth on 2/1/22.
//


/// Letter Grade for the student.
enum LetterGrade: String {
    case A          = "A"
    case A_minus    = "A-"
    case B_plus     = "B+"
    case B          = "B"
    case B_minus    = "B-"
    case C_plus     = "C+"
    case C          = "C"
    case D          = "D"
    case E          = "E"
    case invalidGrade   = "Invalid Grade"
    
    
    /// Initializes the Letter Grade based upon the score.
    public init(withScore score: Double) {
        if score <= 0.0 {self = .E; return}
        if score > 100.0 {self = .A; return}
        
        switch score {
        case 0.0..<55.0: self = .E
        case 55.0..<65: self = .D
        case 65..<72: self = .C
        case 72..<75: self = .C_plus
        case 75..<78: self = .B_minus
        case 78..<81: self = .B
        case 81..<85: self = .B_plus
        case 85..<90: self = .A_minus
        case 90...100: self = .A
        default: self = .invalidGrade
        }
    }
}

extension LetterGrade: Comparable {
    static func < (lhs: LetterGrade, rhs: LetterGrade) -> Bool {
        lhs.comparableInt() < rhs.comparableInt()
    }
    
    func comparableInt() -> Int {
        switch self {
        case .A: return 9
        case .A_minus: return 8
        case .B_plus: return 7
        case .B: return 6
        case .B_minus: return 5
        case .C_plus: return 4
        case .C: return 3
        case .D: return 2
        case .E: return 1
        case .invalidGrade: return 0
        }
    }
}
