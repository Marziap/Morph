//
//  SettingsView.swift
//  Morph
//
//  Created by Marzia Pirozzi on 28/10/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("active_icon") var activeAppIcon: String = "AppIcon"
    
    @State private var settings = SettingsData()
    
    @Environment(Datas.self) private var datas
    
    
    func colorToString (color: Color)-> String {
        
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return "\(red),\(green),\(blue),\(alpha)"
    }
    
    @State private var color = Color.green
    
    var body: some View {
        NavigationStack{
            
            
            List {
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
                        .accentColor(datas.color)
                        
                                        
                    
                }.onChange(of: color) {
                    settings.selectedColor = colorToString(color: color)
                    datas.color=color
                }
                
                
            }
            .navigationTitle("Aspect settings")
            //.padding(.horizontal, 40)
            
            .onChange(of: activeAppIcon){newValue in
                UIApplication.shared.setAlternateIconName(newValue)
            }
        }
        .listStyle(.plain)
    }
}

