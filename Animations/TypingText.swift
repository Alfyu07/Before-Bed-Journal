//
//  File.swift
//  
//
//  Created by Wahyu Alfandi on 18/04/23.
//

import SwiftUI




struct TypingText: View {
    let text: String
    @State private var animatedText = ""
    
    var body: some View {
        Text(animatedText)
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.all, 24)
            .onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                    if self.animatedText.count < self.text.count {
                        self.animatedText += String(self.text[self.animatedText.endIndex])
                    } else {
                        timer.invalidate()
                    }
                }
                timer.fire()
            }
    }
    
}

