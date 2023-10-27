//
//  Data.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import Foundation
import SwiftUI

@Observable class Datas{
     var sounds:[Sound] = [
        Sound(name: "Leaves", tag: "relax", color: .green),
        Sound(name: "Voice", tag: "Alex", color: .yellow),
        Sound(name: "Fire", tag: "relax", color: .red),
        Sound(name: "Rain", tag: "sad", color: .teal),
        Sound(name: "Dog", tag: "🐶", color: .orange)
    ]
    
     var music:[Music] = [
        Music(name: "First attempt", tag: "🥸", color: .red, sounds: [Sound(name: "Sound 1", tag: "ciao", color: .green),
                                                                      Sound(name: "Sound 2", tag: "ciao", color: .yellow),
                                    Sound(name: "Sound 3",tag: "ciao", color: .red),
                                    Sound(name: "Sound 4",tag: "ciao", color: .teal)]),
        Music(name: "Nature", tag: "autumn", color: .orange, sounds: [Sound(name: "Sound 1",tag: "ciao", color: .green),
                       Sound(name: "Sound 2",tag: "ciao", color: .yellow),
                       Sound(name: "Sound 3",tag: "ciao", color: .red),
                       Sound(name: "Sound 4",tag: "ciao", color: .teal)])
    ]
    
     var mixSounds: [Sound] = []
    
}

