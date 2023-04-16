//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 16/04/23.
//

import SwiftUI

struct MyProgressBar: View {
    var color : Color
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in    
            ZStack (alignment: .leading){
                Rectangle().frame(width: geometry.size.width , height: 30)
                    .opacity(0.3)
                    .foregroundColor(.black)

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 30)
                        .foregroundColor(color)
            }.cornerRadius(8)
        }
    }
}

