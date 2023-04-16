//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 17/04/23.
//

import SwiftUI

struct AnswerBox: View {
    var question : Question
    var body: some View {
        VStack(spacing: 0){
            Text(question.question)
                .frame(maxWidth: 220)
                .font(caveat.bodyBold)
            
            ZStack{
                Text(question.longAnswer).frame(maxWidth: 220)
                    .font(caveat.bodyRegular)
                
                ZStack{
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .background(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: 220)
                    Text("Drop here")
                }
            }
            
        }
    }
    
}
