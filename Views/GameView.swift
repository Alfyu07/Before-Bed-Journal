//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 12/04/23.
//

import SwiftUI

struct GameView: View {
    @StateObject var gameViewModel = GameStateViewModel()
    
    @State private var arrowPosition = CGPoint(x: 190, y: 380)
    @State var dialogueState : Bool = false
    @State var gamePlayState : Bool = false
    @State var winState : Bool = false
    @State var initialState: Bool = true
    
    //state
    @State var happinessValue: Float = 0.1
    @State var stressValue: Float = 0.7
    @State var motivationValue: Float = 0.2
    
    
    var body: some View {
        GeometryReader{
            geometry in
            
            ZStack(alignment: .top){
                if(initialState){
                    Image("closedBook")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 70)
                        .rotationEffect(.degrees(-40))
                        .position(x :190, y : 450)
                        .onTapGesture {
                            print("masuk ke game state")
                            initialState = false
                            gamePlayState = true
                        }
                        .onAppear{
                            withAnimation(.easeInOut(duration: 1).repeatForever()){
                                arrowPosition = CGPoint(x: 190, y: 360)
                            }
                        }
                }
                else if(gamePlayState){
                    VStack(alignment: .leading, spacing: 0){
                        Spacer()
                            .frame(height: defaultMargin)
                        
                        HStack(alignment: .top, spacing: 0){
                            //moodbar
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
                            .frame(maxWidth: geometry.size.width * 0.2, maxHeight: 280)
                            .background(Color("chocolate"))
                            .cornerRadius(12)
                          
                            Spacer().frame(width: 12)
                            //Book
                            ZStack(alignment: .topLeading){
                                Image("openBook").resizable().scaledToFit().frame(maxHeight:  geometry.size.height * 0.8)
                                    .padding(.bottom, 120)
                                
                                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], alignment: .top, spacing: 60) {
                                    ForEach(gameViewModel.questions, id: \.id) { item in
                                        AnswerBox(question: item)
                                    }
                                }.frame(maxHeight: geometry.size.height * 0.5)
                                .padding(.vertical, 50)
                                    .padding(.horizontal, 80)
                            }
                            
                            
                            VStack(alignment : .leading, spacing: 0){
                                Text("Drag and drop the right answer into the box.")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                
                                ForEach(gameViewModel.questions, id: \.id){
                                    question in
                                    QuestionBox(question: question).padding(.top, 12)
                                }
                                
                                
                            }.padding(.all, 24)
                                .frame(maxWidth: geometry.size.width * 0.2, maxHeight: geometry.size.height * 0.7)
                                .background(Color("chocolate"))
                                .cornerRadius(12)
                                
                        }
                        
                        Spacer()
                        
                        //chat/msg bar
                        ZStack(){
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 136).cornerRadius(20)
                        .background(chocolate)
                        .cornerRadius(20)
                        
                        Spacer().frame(height: defaultMargin)
                    }.padding(.horizontal, defaultMargin)
                        .onAppear{
                            withAnimation(.easeIn(duration: 3)){
                                
                            }
                        }
                }
                else if(dialogueState){
                    DialogueBox(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent efficitur ligula vitae velit semper, in malesuada sapien sollicitudin. Sed ultricies diam vel fringilla dapibus.")
                    Image("closedBook")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 70)
                        .rotationEffect(.degrees(-40))
                        .position(x :190, y : 450)
                        .onTapGesture {
                            print("masuk ke game state")
                        }
                }
                
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image(winState ? "lightBg" : "darkBg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
    }
    
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
