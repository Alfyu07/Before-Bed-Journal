//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 15/04/23.
//

import SwiftUI
let soundManager = SoundManager()
struct MainMenuView: View {
    //state for navigating to mainView
    @State var isShowingMainView : Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            Spacer().frame(height: 225)
            HStack(spacing: 0){
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 215)
                    .foregroundColor(Color("darkOrange"))
                    
                Text("Before Bed \nJournal")
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.leading, 36)
            }
            Spacer()
                .frame(height: 80)
            
           
                
            NavigationLink(destination: GameView()){
                ZStack{
                    Circle().fill(Color("yellow"))
                        .frame(maxWidth: 150, maxHeight: 150)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(maxWidth: 80, maxHeight: 80)
                        .foregroundColor(.white).padding(.leading, 18)
                }.shadow(color: Color("yellow").opacity(0.6), radius: 40, x: 0, y: 4)
            }
            
            Spacer()
                .frame(height: 80)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("mainMenuBg").resizable()
            .scaledToFill())
        .ignoresSafeArea()
    }
}
