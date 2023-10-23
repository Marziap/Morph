//
//  TabBarView.swift
//  Morph
//
//  Created by Marzia Pirozzi on 20/10/23.
//

import Foundation
import SwiftUI

struct TabLayoutView: View {
    
    var body: some View {
        
        TabView{
            LibraryView()
                .tabItem {Label("Learners", systemImage: "person.fill")}
            MixingView()
                .tabItem {Label("Teams", systemImage: "person.3.fill")}
        }
        
    }
}
