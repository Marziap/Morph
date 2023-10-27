//
//  Model.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import Foundation
import SwiftUI

@Observable class Sound: Identifiable{
    var id: UUID = UUID()
    var name: String = "sound name"
    var tag: String = "tag"
    var audio: String = "audio"
    var image: String = "waveform"
    var color: Color = .blue
    var isPlaying: Bool = false
   // var fileUrl: URL = URL (string: "ciao")!
    
    init(name: String, tag: String, color: Color) {
        //self.id = id
        self.name = name
        self.tag = tag
        //self.audio = audio
        //self.image = image
        self.color = color
        //self.isPlaying = isPlaying
    }
    
}

@Observable class Music: Identifiable{
    var id: UUID = UUID()
    var name: String = "music name"
    var tag: String = "tag"
    var audio: String = "audio"
    var image: String = "music.quarternote.3"
    var color: Color = .blue
    var sounds: [Sound] = []

    
    init(name: String, tag: String, color: Color, sounds: [Sound]) {
        //self.id = id
        self.name = name
        self.tag = tag
       // self.audio = audio
        //self.image = image
        self.color = color
        self.sounds = sounds
    }
}
