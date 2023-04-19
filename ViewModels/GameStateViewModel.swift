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
    @Published var showDrop: [Bool] = []
    @Published var errorState : [Bool] = []
    
    @Published var firstMonolog: [String] = [
    "Ugh... I'm so exhausted today from being busy with work and running around to meetings. And don't even get me started on my home responsibilities.",
    "I had a packed day from morning till night, and all my energy feels drained from all this work... Not to mention, I'm having issues with my colleagues at work.",
    "I'm so tired, I need to clear my head of all this... What can I do?",
    ]
    
    @Published var lastMonolog: [String] = [
        "Wow...",
        "I feel so much calmer after writing in my journal. Before, I felt super tired, exhausted, and stressed. But after I wrote down all my thoughts and feelings, it's like all the weight on my mind is lifted. Now, I can think more clearly and figure out how to deal with my problems.",
        "I think writing in a journal can also help me get rid of negative thoughts that might hold me back in my daily life. It's like all the positive energy comes back to me... I feel more motivated to face the days ahead.",
        "I've felt the benefits... Now, it's your turn to try it in your life!",
        "See you later!",
    ]
   
    @Published var counter : Int = 0
    
    init() {
        showDrop = Array(repeating: true, count: questions.count)
        errorState = Array(repeating: false, count: questions.count)
    }
    
}

var dummyQuestions : [Question] = [
    Question(questionText: "What am I grateful for today and what makes me feel grateful?", type: QuestionType.grateful),
    Question(questionText: "What was the best thing that happened to me today and how did it make me feel?", type: QuestionType.bestThingHappen),
    Question(questionText: "What didn't go well today and what can I do to improve it?", type: QuestionType.didntGoWell),
    Question(questionText: "What is one thing I want to achieve or work on tomorrow and what is my plan to do it?",  type: QuestionType.target),
]

var dummyAnswers : [Answer] = [
    Answer(longAnswerText: "Today, I'm grateful for the support of my friends and loved ones during a difficult time. It makes me feel grateful to have a strong support system and to know that I'm not alone.", answerText: "Im so grateful after boss complimented. Learned positive reinforcement can impact mood/motivation.", type: QuestionType.grateful),
    Answer(longAnswerText: "The best thing that happened to me today was finally finishing a tedious task. It made me feel relieved, but also frustrated that it took so long to complete.", answerText: "The best thing that happened to me today was finally finishing a tedious task.", type: QuestionType.bestThingHappen),
    Answer(longAnswerText: "Today, I had a tough talk with a colleague and felt upset. To improve, I'll practice active listening and empathy, and seek common ground instead of escalating the conflict.", answerText: "I had a tough talk with a colleague and felt upset. To improve, I'll practice active listening and empathy.", type: QuestionType.didntGoWell),
    Answer(longAnswerText: "Tomorrow, I have a deadline approaching for a project that I haven't started yet. My plan is to stay up all night working on it", answerText: "Tomorrow, I have a deadline for a project that I haven't started yet. My plan is to stay up all night working on it.", type: QuestionType.target)
]
