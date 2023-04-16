//
//  LazyHGridView.swift
//  BedJournal
//
//  Created by Wahyu Alfandi on 17/04/23.
//

import SwiftUI

struct LazyHGridView: View {
    let items = Array(1...4)
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Text("\(item)")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

struct LazyHGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyHGridView()
    }
}
