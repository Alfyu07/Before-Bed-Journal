//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 16/04/23.
//

import SwiftUI

struct QuestionBox: View {
    @ObservedObject var answer: Answer
    
    var body: some View {
        Text(answer.answerText)
            .font(.system(size: 14))
            .padding(.all, 10)
            .frame(maxWidth: 220)
            .fixedSize(horizontal: false, vertical: true)
            .background(.white)
            .cornerRadius(8)
    }
}

