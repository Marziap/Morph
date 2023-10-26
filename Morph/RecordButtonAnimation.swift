//
//  RecordButtonAnimation.swift
//  Morph
//
//  Created by Giorgio Caiazzo on 25/10/23.
//

import Foundation
import SwiftUI



struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onSecondPress: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onSecondPress()
                    })
            )
    }
}

//  Written by SerialCoder.dev
extension View {
    func pressEvents(onPress: @escaping (() -> Void), onSecondPress: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: {
            onPress()
        }, onSecondPress: {
            onSecondPress()
        }))
    }
} 

