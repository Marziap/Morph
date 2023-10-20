//
//  Data.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import Foundation
import SwiftUI

class Data: ObservableObject{
    @Published var sounds:[Sounds] = [
        Sounds(name: "Sound 1", color: .green),
        Sounds(name: "Sound 2", color: .yellow),
        Sounds(name: "Sound 3", color: .red),
        Sounds(name: "Sound 4", color: .teal),
        Sounds(name: "Sound 5", color: .orange)
    ]
    
    @Published var mixSounds: [Sounds] = []
}

var data = Data()
