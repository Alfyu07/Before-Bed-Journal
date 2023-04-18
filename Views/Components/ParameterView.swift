//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 18/04/23.
//

import SwiftUI

struct ParameterView: View {
    @Binding var happinessValue : Float
    @Binding var stressValue : Float
    @Binding var motivationValue : Float
    
    
    var body: some View {
        VStack(alignment : .leading, spacing: 0){
            
            HStack(spacing: 0){
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 6)
                
                Text("Happiness")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }.foregroundColor(pink)
            
            MyProgressBar(color: pink, value: $happinessValue).padding(.top, 8)
            
            HStack(spacing: 0){
                Text("💢")
                    .font(.system(size : 20))
                    .padding(.trailing, 6)
                
                Text("Stress")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }
            .foregroundColor(red).padding(.top, 12)
            
            MyProgressBar(color: red, value: $stressValue).padding(.top, 8)
            
            HStack(spacing: 0){
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.trailing, 6)
                
                Text("Motivation")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }.foregroundColor(orange)
                .padding(.top, 12)
            
            
            MyProgressBar(color: orange, value: $motivationValue).padding(.top, 8)
        }
        .padding(.all, 24)
        .frame(maxWidth: 250, maxHeight: 280)
        .background(Color("chocolate"))
        .cornerRadius(12)
        
    }
}


