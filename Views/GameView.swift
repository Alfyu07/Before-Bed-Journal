//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 12/04/23.
//

import SwiftUI

struct GameView: View {
    @StateObject var gameViewModel = GameStateViewModel()
    
    @State  var arrowPosition = CGPoint(x: 190, y: 380)
    @State var dialogueState : Bool = false
    @State var gamePlayState : Bool = false
    @State var winState : Bool = false
    @State var initialState: Bool = true
    
    @State private var showDrop: [Bool] = [true, true, true, true]
    @State var errorState : [Bool] = [false, false, false, false]
    //state moodbar
    @State var happinessValue: Float = 0.1
    @State var stressValue: Float = 0.7
    @State var motivationValue: Float = 0.2
    
    //state feedback state
    @State var gratefulFeedback = false
    @State var targetFeedback = false
    @State var bestThingFeedback = false
    @State var didntGoWellFeedback = false
   
    
    func resetFeedbackState(){
        
        gratefulFeedback = false
        targetFeedback = false
        bestThingFeedback = false
        didntGoWellFeedback = false
    }
    
    //dispatchQueue
    let dispatchQueue = DispatchQueue(label: "update", qos: .background)
    

 
    
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
                        .position(arrowPosition)
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
                                    
                                    ForEach(Array(zip(gameViewModel.questions, gameViewModel.answers)), id: \.0.id) { question, answer in
                                        VStack(spacing: 0){
                                            Text(question.questionText)
                                                .frame(maxWidth: 220)
                                                .font(caveat.bodyBold)
                                            
                                            ZStack{
                                                if (showDrop[gameViewModel.answers.firstIndex(of: answer) ?? 0]) {
                                                        Rectangle()
                                                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                            .background(.white)
                                                            .cornerRadius(10)
                                                            .frame(maxWidth: 220)
                                                        Text("Drop here")
                                                } else {
                                                    Text(answer.longAnswerText).frame(maxWidth: 220)
                                                        .font(caveat.bodyRegular)
                                                }
                                            }.modifier(Shake(animatableData: CGFloat(errorState[gameViewModel.answers.firstIndex(of: answer) ?? 0] ? 1 : 0)))
                                        }
                                        .onDrop(of: [.url], isTargeted: .constant(false)){
                                            providers in
                                            
                                            if let first = providers.first{
                                                let _ = first.loadObject(ofClass: URL.self){
                                                    value, error in
                                                    
                                                    guard let url = value else{return}
                                                    
                                                    if String(question.type.rawValue) == "\(url)" {
                                                        
                                                        dispatchQueue.async{
                                                            //Time consuming task here
                                                            DispatchQueue.main.async{
                                                                question.isShowing = false
                                                                answer.isShowing = false
                                                                let index = gameViewModel.answers.firstIndex(of: answer) ?? 0
                                                                showDrop[index] = false
                                                                
                                                                resetFeedbackState()
                                                                switch question.type{
                                                                case QuestionType.grateful :
                                                                    gratefulFeedback = true
                                                                    break
                                                                case QuestionType.bestThingHappen:
                                                                    bestThingFeedback = true
                                                                    break
                                                                case QuestionType.didntGoWell:
                                                                    didntGoWellFeedback = true
                                                                    break
                                                                case QuestionType.target:
                                                                    targetFeedback = true
                                                                    break
                                                                }
                                                                errorState = Array.init(repeating: false, count: 4)
                                                            }
                                                        }
                                                    }
                                                    else{
                                                        withAnimation{
                                                            errorState[gameViewModel.answers.firstIndex(of: answer) ?? 0] = true
                                                        }
                                                        errorState = Array.init(repeating: false, count: 4)
                                                        
                                                    }
                                                }
                                            }
                                            
                                            return false
                                        }
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
                                
                                
                                ForEach(gameViewModel.answers.shuffled(), id: \.id){
                                    answer in
//                                    QuestionBox(answer: answer).padding(.top, 12).onDrag{
//                                        return .init(contentsOf: URL(string: String(answer.type.rawValue)))!
//                                    }
                                    
                                    if (showDrop[gameViewModel.answers.firstIndex(of: answer) ?? 0]) {
                                        QuestionBox(answer: answer).padding(.top, 12).onDrag{
                                            return .init(contentsOf: URL(string: String(answer.type.rawValue)))!
                                        }
                                    }
                                }
                                
                                Spacer()
                            }.padding(.all, 24)
                                .frame(maxWidth: geometry.size.width * 0.2, maxHeight: geometry.size.height * 0.7)
                                .background(Color("chocolate"))
                                .cornerRadius(12)
                            
                        }
                        
                        Spacer()
                        
                        //chat/msg bar
                        ZStack(){
                            if(gratefulFeedback){
                                TypingText(text : "Keeping a gratitude journal can be a fun way to reduce stress and improve your mood. By taking time each day to reflect on the things you're thankful for, you may find yourself feeling happier and more content.")
//                                Text("Keeping a gratitude journal can be a fun way to reduce stress and improve your mood. By taking time each day to reflect on the things you're thankful for, you may find yourself feeling happier and more content.").font(.system(size: 24, weight: .semibold, design: .rounded)).foregroundColor(.white)
                            }else if(didntGoWellFeedback){
                                TypingText(text : "Reflecting on the things that didn't go well today and how to make them better in your journal can help you grow, improve, and feel better!")
                                
//                                Text("Reflecting on the things that didn't go well today and how to make them better in your journal can help you grow, improve, and feel better!").font(.system(size: 24, weight: .semibold, design: .rounded)).foregroundColor(.white)
                            }else if(bestThingFeedback){
                                TypingText(text : "Reflecting on the best thing that happened to you today and how it made you feel in your journal can help you stay focused on the positive, boost your mood, and increase your overall well-being!")
//                                Text("Reflecting on the best thing that happened to you today and how it made you feel in your journal can help you stay focused on the positive, boost your mood, and increase your overall well-being!").font(.system(size: 24, weight: .semibold, design: .rounded)).foregroundColor(.white)
                            }else if(targetFeedback){ //target
                                TypingText(text: "Take charge of your life and your goals! This simple yet powerful journaling prompt can help you stay on track, motivated, and inspired to achieve your dreams and aspirations!")
//                                Text("Take charge of your life and your goals! This simple yet powerful journaling prompt can help you stay on track, motivated, and inspired to achieve your dreams and aspirations!").font(.system(size: 24, weight: .semibold, design: .rounded)).foregroundColor(.white)
                            }else{
                                Text("Hey there, wordsmith! Let's put those fingers to work and start writing up a storm!").font(.system(size: 24, weight: .semibold, design: .rounded)).foregroundColor(.white)
                            }
                        }
                        .padding(.all, 24)
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
        GameView().previewDevice("iPad (10th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
