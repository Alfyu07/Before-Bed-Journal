//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 18/04/23.
//

import Foundation


class Answer :Equatable, ObservableObject {
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        return lhs.id == rhs.id && lhs.longAnswerText == rhs.longAnswerText && lhs.answerText == rhs.answerText && lhs.type == rhs.type && lhs.isShowing == rhs.isShowing
    }
    
    @Published var id : String = UUID().uuidString
    @Published var longAnswerText : String
    @Published var answerText : String
    @Published var type : QuestionType
    @Published var isShowing : Bool = false
    
    init(longAnswerText : String, answerText : String, type: QuestionType) {
        self.longAnswerText = longAnswerText
        self.answerText = answerText
        self.type = type
    }
    
}
