//
//  Model.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import Foundation
import SwiftUI

struct Sounds: Identifiable{
    var id: UUID = UUID()
    var name: String = "sound name"
    var tag: String = "tag"
    var audio: String = "audio"
    var image: String = "waveform"
    var color: Color = .blue
}
