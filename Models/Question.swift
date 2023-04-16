//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 16/04/23.
//

import Foundation

class Question : Equatable, ObservableObject{
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id && lhs.question == rhs.question &&
        lhs.answer == rhs.answer && lhs.longAnswer == rhs.longAnswer
    }
    
    @Published var id : String = UUID().uuidString
    @Published var question: String
    @Published var answer: String
    @Published var longAnswer : String
    
    init(question: String, answer: String, longAnswer : String) {
        self.question = question
        self.answer = answer
        self.longAnswer = longAnswer
    }
}
