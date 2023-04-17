//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 14/04/23.
//

import Foundation


class GameStateViewModel : ObservableObject{
    @Published var questions : [Question] = dummyQuestions
    @Published var answers : [Answer] = dummyAnswers
    
    init() {
        
    }
    
    func initQuestion(){
        
    }
}

var dummyQuestions : [Question] = [
    Question(questionText: "What am I grateful for today and what makes me feel grateful?", type: QuestionType.grateful),
    Question(questionText: "What was the best thing that happened to me today and how did it make me feel?", type: QuestionType.bestThingHappen),
    Question(questionText: "What didn't go well today and what can I do to improve it?", type: QuestionType.didntGoWell),
    Question(questionText: "What is one thing I want to achieve or work on tomorrow and what is my plan to do it?",  type: QuestionType.target),
]

var dummyAnswers : [Answer] = [
    Answer(longAnswerText: "Today, I'm grateful for the support of my friends and loved ones during a difficult time. It makes me feel grateful to have a strong support system and to know that I'm not alone.", answerText: "I felt grateful after boss complimented. Learned positive reinforcement can impact mood/motivation.", type: QuestionType.grateful),
    Answer(longAnswerText: "The best thing that happened to me today was finally finishing a tedious task. It made me feel relieved, but also frustrated that it took so long to complete.", answerText: "The best thing that happened to me today was finally finishing a tedious task.", type: QuestionType.bestThingHappen),
    Answer(longAnswerText: "Today, I had a tough talk with a colleague and felt upset. To improve, I'll practice active listening and empathy, and seek common ground instead of escalating the conflict.", answerText: "Today, I had a tough talk with a colleague and felt upset. To improve, I'll practice active listening and empathy..", type: QuestionType.didntGoWell),
    Answer(longAnswerText: "Tomorrow, I have a deadline approaching for a project that I haven't started yet. My plan is to stay up all night working on it", answerText: "Tomorrow, I have a deadline for a project that I haven't started yet. My plan is to stay up all night working on it.", type: QuestionType.target)
]
