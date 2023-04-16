import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            MainMenuView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
