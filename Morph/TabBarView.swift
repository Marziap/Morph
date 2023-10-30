//
//  TabBarView.swift
//  Morph
//
//  Created by Marzia Pirozzi on 20/10/23.
//

import Foundation
import SwiftUI

struct TabLayoutView: View {
    
    @State private var datas = Datas()
    @State private var settings = SettingsData()
    
    var body: some View {
        
        TabView{
            LibraryView()
                .tabItem {Label("Library", systemImage: "music.note.list")}
            MixingView()
                .tabItem {Label("Mix", systemImage: "opticaldisc")}
        }.task {
            if (settings.selectedColor != "" ) {
                
                let rgbArray = settings.selectedColor.components(separatedBy: ",")
                if let red = Double (rgbArray[0]), let green = Double (rgbArray[1]), let blue = Double(rgbArray[2]), let alpha = Double (rgbArray[3]){ datas.color = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
                }
            }
        }
        .environment(datas)
            .tint(datas.color)
        
    }
}
