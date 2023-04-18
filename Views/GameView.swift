//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 12/04/23.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameStateViewModel()
    @State  var bookPosition = CGPoint(x: 190, y: 380)
    
    //game state
    @State var dialogueState : Bool = true
    @State var gamePlayState : Bool = false
    @State var winState : Bool = false
    @State var initialState: Bool = false
    
    //state moodbar
    @State var happinessValue: Float = 0.1
    @State var stressValue: Float = 0.7
    @State var motivationValue: Float = 0.2
    
    //state feedback state
    @State var gratefulFeedback = false
    @State var targetFeedback = false
    @State var bestThingFeedback = false
    @State var didntGoWellFeedback = false
    
    //animation state
    @State var onAnimation = false
    @State var isShowingText = false
    @State var hideDialogue = false
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
                    VStack{
                        Image("closedBook")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 70)
                            .rotationEffect(.degrees(-40))
                            .position(bookPosition)
                            .onTapGesture {
                                print("masuk ke game state")
                                initialState = false
                                gamePlayState = true
                            }
                            .onAppear{
                                withAnimation(.easeInOut(duration: 1).repeatForever()){
                                    bookPosition = CGPoint(x: 190, y: 360)
                                }
                            }
                        ZStack{
                            TypingText(text: "My journal book, I haven't filled it in for a long time, maybe I should grab it.", onAnimation: $onAnimation)
                        }.padding(.all, 24)
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.1)
                            .cornerRadius(20)
                            .background(chocolate)
                            .cornerRadius(20)
                            .padding(.horizontal, defaultMargin)
                            .opacity(hideDialogue ? 0.0 : 1.0)
                            .onAppear() {
                                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                                    withAnimation(.easeOut(duration: 2)){
                                        self.hideDialogue = true
                                    }
                                }
                            }
                    }
                    
                }
                else if(dialogueState){
                    VStack(spacing : 0){
                        Spacer()
                        ZStack(alignment: .bottomTrailing){
                            Rectangle()
                                .fill(chocolate)
                                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.3)
                            VStack(alignment: .trailing){
                                Spacer()
                                ForEach(viewModel.firstMonolog.indices){ i in
                                    if(viewModel.counter == i){
                                        TypingText(text : viewModel.firstMonolog[viewModel.counter], onAnimation: $onAnimation)
                                    }
                                }
                                Spacer()
                                Text("Tap to next")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .opacity(isShowingText ? 1.0 : 0.2)
                                    .onAppear{
                                        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                                            self.isShowingText.toggle() // toggle show/hide text repeatedly with easing animation
                                        }
                                    }
                            }
                        }
                        .padding(.all, 24)
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.3)
                        .cornerRadius(20)
                        .background(chocolate)
                        .cornerRadius(20)
                        .padding(.horizontal, defaultMargin)
                        
                        Spacer()
                        Image("mad").resizable().scaledToFit().frame(maxHeight: 450).ignoresSafeArea()
                    }
                    .onTapGesture {
                        if viewModel.counter < viewModel.firstMonolog.count - 1 {
                            viewModel.counter += 1
                        } else {
                            dialogueState = false
                            initialState = true
                            viewModel.counter = 0
                        }
                    }
                }
                else if(gamePlayState){
                    VStack(alignment: .leading, spacing: 0){
                        Spacer()
                            .frame(height: defaultMargin)
                        
                        HStack(alignment: .top, spacing: 0){
                            //moodbar
                            ParameterView(happinessValue: $happinessValue, stressValue: $stressValue, motivationValue: $motivationValue)
                            
                            Spacer().frame(width: 12)
                            //Book
                            ZStack(alignment: .topLeading){
                                Image("openBook").resizable().scaledToFit().frame(maxHeight:  geometry.size.height * 0.8)
                                    .padding(.bottom, 120)
                                
                                LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], alignment: .top, spacing: 60) {
                                    
                                    ForEach(Array(zip(viewModel.questions, viewModel.answers)), id: \.0.id) { question, answer in
                                        VStack(spacing: 0){
                                            Text(question.questionText)
                                                .frame(maxWidth: 220)
                                                .font(caveat.bodyBold3)
                                            
                                            ZStack{
                                                if (viewModel.showDrop[viewModel.answers.firstIndex(of: answer) ?? 0]) {
                                                    Rectangle()
                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                        .background(.white)
                                                        .cornerRadius(10)
                                                        .frame(maxWidth: 220, maxHeight: 200)
                                                    Text("Drop here")
                                                } else {
                                                    Text(answer.longAnswerText).frame(maxWidth: 220)
                                                        .font(caveat.bodyRegular2)
                                                }
                                            }.modifier(Shake(animatableData: CGFloat(viewModel.errorState[viewModel.answers.firstIndex(of: answer) ?? 0] ? 1 : 0)))
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
                                                                
                                                                let index = viewModel.answers.firstIndex(of: answer) ?? 0
                                                                viewModel.showDrop[index] = false
                                                                
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
                                                                viewModel.errorState = Array.init(repeating: false, count: viewModel.questions.count)
                                                            }
                                                        }
                                                    }
                                                    else{
                                                        dispatchQueue.async{
                                                            DispatchQueue.main.async{
                                                                withAnimation{
                                                                    viewModel.errorState[viewModel.answers.firstIndex(of: answer) ?? 0] = true
                                                                }
                                                                viewModel.errorState = Array.init(repeating: false, count: viewModel.questions.count)
                                                            }
                                                        }
                                                        
                                                        
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
                                
                                
                                ForEach(viewModel.answers.shuffled(), id: \.id){
                                    answer in
                                    
                                    if (viewModel.showDrop[viewModel.answers.firstIndex(of: answer) ?? 0]) {
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
                                TypingText(text : "Keeping a gratitude journal can be a fun way for me to reduce stress and improve my mood. By taking time each day to reflect on the things I'm thankful for, I may find myself feeling happier and more content.", onAnimation: $onAnimation).onChange(of: onAnimation){
                                    onAnimation in
                                    
                                    if(!onAnimation && viewModel.showDrop.allSatisfy({!$0})){
                                        print("selesaiiiiii")
                                    }
                                    
                                }
                                
                            }else if(didntGoWellFeedback){
                                TypingText(text : "When I reflect on the things that didn't go well today and think of ways to make them better in my journal, I can grow, improve, and feel better about myself.", onAnimation : $onAnimation).onChange(of: onAnimation){
                                    onAnimation in
                                    moveToNextPhase(onAnimation: onAnimation)
                                }
                                
                            }else if(bestThingFeedback){
                                TypingText(text : "Reflecting on the best thing that happened to me today and how it made me feel in my journal really helps me stay positive. It has a great impact on my mood and well-being.", onAnimation : $onAnimation).onChange(of: onAnimation){
                                    onAnimation in
                                    moveToNextPhase(onAnimation: onAnimation)
                                }
                                
                            }else if(targetFeedback){ //target
                                TypingText(text: "I need to take charge of my life and my goals. This simple yet powerful journaling prompt can help me stay on track, motivated, and inspired to achieve my dreams and aspirations", onAnimation : $onAnimation).onChange(of: onAnimation){
                                    onAnimation in
                                    moveToNextPhase(onAnimation: onAnimation)
                                }
                                
                            }else{
                                TypingText(text: "Maybe.. I can write it all down on this journal to calm my mind...", onAnimation : $onAnimation)
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
                } else if(winState){
                    VStack(spacing : 0){
                        Spacer()
                        ZStack(alignment: .bottomTrailing){
                            Rectangle()
                                .fill(chocolate)
                                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.3)
                            VStack(alignment: .trailing){
                                Spacer()
                                ForEach(viewModel.lastMonolog.indices){ i in
                                    if(viewModel.counter == i){
                                        TypingText(text : viewModel.lastMonolog[viewModel.counter], onAnimation: $onAnimation)
                                    }
                                }
                                Spacer()
                                Text("Tap to next")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .opacity(isShowingText ? 1.0 : 0.2)
                                    .onAppear{
                                        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                                            self.isShowingText.toggle() // toggle show/hide text repeatedly with easing animation
                                        }
                                    }
                            }
                        }
                        .padding(.all, 24)
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.3)
                        .cornerRadius(20)
                        .background(chocolate)
                        .cornerRadius(20)
                        .padding(.horizontal, defaultMargin)
                        
                        Spacer()
                        Image("happy").resizable().scaledToFit().frame(maxHeight: 450).ignoresSafeArea()
                    }
                    .onTapGesture {
                        if viewModel.counter < viewModel.lastMonolog.count - 1 {
                            viewModel.counter += 1
                        } else {
                            dialogueState = false
                            initialState = false
                        }
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
    
    func moveToNextPhase(onAnimation : Bool){
        if(!onAnimation && viewModel.showDrop.allSatisfy({!$0})){
            winState = true
            gamePlayState = false
        }
    }
    
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().previewDevice("iPad (10th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
