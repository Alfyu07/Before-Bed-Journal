//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 16/04/23.
//

import Foundation

enum QuestionType:String{
    case grateful = "grateful"
    case bestThingHappen = "bestThingHappen"
    case didntGoWell = "didntGoWell"
    case target = "target"
    
}

class Question : Equatable, ObservableObject{
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id && lhs.questionText == rhs.questionText && lhs.type == lhs.type
    }
    
    
    @Published var id : String = UUID().uuidString
    @Published var questionText: String
    @Published var type: QuestionType
    @Published var isShowing : Bool = false
    
    
    init(questionText: String, type: QuestionType) {
        self.questionText = questionText
        self.type = type
    }
}
