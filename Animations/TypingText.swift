//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 18/04/23.
//

import SwiftUI




struct TypingText: View {
    @State var text: String
    @State private var animatedText = ""
    @Binding var onAnimation : Bool
    
    func animateText() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { timer in
            if self.animatedText.count < self.text.count {
                self.animatedText += String(self.text[self.animatedText.endIndex])
            } else {
                timer.invalidate()
                onAnimation = false
            }
        }
        timer.fire()
    }
    
    
    var body: some View {
        Text(animatedText)
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.all, 24)
            .onAppear {
                onAnimation = true
                animateText()
            }
            .onChange(of: text) { _ in
                animatedText = ""
                animateText()
            }
    }
    
}

