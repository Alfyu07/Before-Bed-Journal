//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 14/04/23.
//

import Foundation


class GameStateViewModel : ObservableObject{
    @Published var questions : [Question] = dummyQuestions
    
    init() {
        
    }
    
    func initQuestion(){
        
    }
}

var dummyQuestions : [Question] = [
    Question(question: "What am I grateful for today and what makes me feel grateful?", answer: "Im so grateful for support of friends/loved ones during difficult time, makes me feel grateful to have strong support system.", longAnswer: "Today, I'm grateful for the support of my friends and loved ones during a difficult time. It makes me feel grateful to have a strong support system and to know that I'm not alone."),
    Question(question: "What was the best thing that happened to me today and how did it make me feel?", answer: "The best thing that happened to me today was finally finishing a tedious task.", longAnswer: "The best thing that happened to me today was finally finishing a tedious task. It made me feel relieved, but also frustrated that it took so long to complete."),
    Question(question: "What didn't go well today and what can I do to improve it?", answer: "Today, I had a difficult conversation with a coworker that left me feeling upset and ", longAnswer: "Today, I had a difficult conversation with a coworker that left me feeling upset and frustrated. To improve, I can try practicing active listening and empathy, and focusing on finding common ground instead of escalating the conflict."),
    Question(question: "What is one thing I want to achieve or work on tomorrow and what is my plan to do it?", answer: "Tomorrow, I have a deadline for a project that I haven't started yet. My plan is to stay up all night working on it.", longAnswer: "Tomorrow, I have a deadline approaching for a project that I haven't started yet. My plan is to stay up all night working on it"),
    
]

