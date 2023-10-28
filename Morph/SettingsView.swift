//
//  SettingsView.swift
//  Morph
//
//  Created by Marzia Pirozzi on 28/10/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("active_icon") var activeAppIcon: String = "AppIcon"
    @Environment(Datas.self) private var datas
    @State private var color = Color.green
    var body: some View {
        NavigationStack{
            
            
            VStack (alignment: .leading){
                
                
                
                HStack {
                    
                    Text("App Icon Color")
                        .font(.title3)
                    
                    Spacer()
                    
                    Picker(selection: $activeAppIcon) {
                        let customIcons: [String] = ["Green", "Red", "Blue", "Violet", "Pink"]
                        
                        ForEach(customIcons, id: \.self){icon in
                            Text(icon)
                                .tag(icon)
                        }
                        
                    } label: {
                        
                    }.tint(datas.color)
                }
                
                
                //accent color
                
                
                HStack {
                    
                    Text("Accent color")
                        .font(.title3)
                    
                    Spacer()
                    
                    ColorPicker("", selection: $color, supportsOpacity: false)
                        .padding(.trailing, 40)
                        .tint(datas.color)
                    
                    
                }.onChange(of: color) {
                    datas.color=color
                }
                
                
            }.navigationTitle("Customize aspect")
                .padding(.horizontal, 40)
            
        }
        .onChange(of: activeAppIcon){newValue in
            print(activeAppIcon)
            UIApplication.shared.setAlternateIconName(newValue)
        }
    }
}

//#Preview {
//    SettingsView()
//}
