//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 14/04/23.
//

import SwiftUI

struct DialogueBox : View {
    var text: String
    var body: some View {
        ZStack{
            Image("dialogueBox")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 900)
                .padding(.top, 80)
            Text(text)
                .font(.system(.title))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: 760, alignment: .leading)
                .padding(.top, 40)
        }
    }
}

