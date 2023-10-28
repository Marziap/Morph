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
    var fileURL: URL
    
    init(name: String, tag: String, color: Color, fileURL: URL) {
        //self.id = id
        self.name = name
        self.tag = tag
        //self.audio = audio
        //self.image = image
        self.color = color
        //self.isPlaying = isPlaying
        self.fileURL = fileURL
    }
    
}

@Observable class Music: Identifiable{
    var id: UUID = UUID()
    var name: String = "music name"
    var tag: String = "tag"
    var audio: String = "audio"
    var image: String = "music.quarternote.3"
    var color: Color = .blue
    var isPlaying: Bool = false
    var fileURL: URL
    var sounds: [Sound] = []
    
    
    init(name: String, tag: String, color: Color, fileURL: URL, sounds: [Sound]) {
        //self.id = id
        self.name = name
        self.tag = tag
        // self.audio = audio
        //self.image = image
        self.color = color
        self.fileURL = fileURL
        self.sounds=sounds
        
    }
}
