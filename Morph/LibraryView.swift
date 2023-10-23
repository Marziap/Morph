//
//  LibraryView.swift
//  Morph
//
//  Created by Marzia Pirozzi on 20/10/23.
//

import SwiftUI

struct LibraryView: View {
    @State private var category = 0
    //for the segmented picker
    
    var body: some View {
        VStack {Text("Sounds")
                .font(.title)
                .fontWeight(.medium)
            //title of the page
            
            Picker("in what category are you?", selection: $category) {
                Text("Sounds").tag(0)
                Text("Music").tag(1) }
            .pickerStyle(.segmented)
            .padding()
            //segmented picker
            ScrollView {
                
                VStack (alignment: .leading) {
                    ForEach(datas.sounds) { sound in
                        
                        HStack  {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .foregroundStyle(sound.color)
                                .padding(.trailing)
                            VStack (alignment: .leading)
                            {
                                Text(sound.name)
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text(sound.tag)
                                    .font(.subheadline)
                            }
                        }
                        .padding()
                  
                        
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ ,alignment: .leading)
                .padding()
            }
            
            
            HStack {
                
                customButton (buttonImage: "mic")
                customButton (buttonImage: "paperclip")
           
                
            }
            
            
        }
    }
    
    
    
    
}
#Preview {
    LibraryView()
}
