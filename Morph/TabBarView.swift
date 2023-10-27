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
    
    var body: some View {
        
        TabView{
            LibraryView()
                .tabItem {Label("Library", systemImage: "music.note.list")}
            MixingView()
                .tabItem {Label("Mix", systemImage: "opticaldisc")}
        }.environment(datas)
        
    }
}

#Preview {
    TabLayoutView()
}
