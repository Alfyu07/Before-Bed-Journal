//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 17/04/23.
//

import SwiftUI

struct AnswerBox: View {
    @ObservedObject var question : Question
    @ObservedObject var answer: Answer
    
    var body: some View {
        VStack(spacing: 0){
            Text(question.questionText)
                .frame(maxWidth: 220)
                .font(caveat.bodyBold)
            
            ZStack{
                Text(answer.longAnswerText).frame(maxWidth: 220)
                    .font(caveat.bodyRegular)
                
                ZStack{
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .background(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: 220)
                    Text("Drop here")
                }.opacity(question.isShowing ? 1 : 0)
            }
            
        }
    }
    
}
