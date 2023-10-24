//
//  Data.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import Foundation
import SwiftUI

class Datas: ObservableObject{
    @Published var sounds:[Sounds] = [
        Sounds(name: "Leaves", tag: "relax", color: .green),
        Sounds(name: "Voice", tag: "Alex", color: .yellow),
        Sounds(name: "Fire", tag: "relax", color: .red),
        Sounds(name: "Rain", tag: "sad", color: .teal),
        Sounds(name: "Dog", tag: "🐶", color: .orange)
    ]
    
    @Published var music:[Music] = [
        Music(name: "First attempt", tag: "🥸", color: .red, sounds: [Sounds(name: "Sound 1", color: .green),
                                    Sounds(name: "Sound 2", color: .yellow),
                                    Sounds(name: "Sound 3", color: .red),
                                    Sounds(name: "Sound 4", color: .teal)]),
        Music(name: "Nature", tag: "autumn", color: .orange, sounds: [Sounds(name: "Sound 1", color: .green),
                       Sounds(name: "Sound 2", color: .yellow),
                       Sounds(name: "Sound 3", color: .red),
                       Sounds(name: "Sound 4", color: .teal)])
    ]
    
    @Published var mixSounds: [Sounds] = []
    
}

var datas = Datas()
