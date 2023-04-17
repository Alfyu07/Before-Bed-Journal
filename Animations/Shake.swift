//
//  SwiftUIView.swift
//  
//
//  Created by Wahyu Alfandi on 18/04/23.
//

import SwiftUI


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = amount * sin(animatableData * .pi * CGFloat(shakesPerUnit))
        return ProjectionTransform(CGAffineTransform(translationX: xTranslation, y: 0))
    }
}
