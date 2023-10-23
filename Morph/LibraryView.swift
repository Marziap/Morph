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
    
    var body: some View  {
        
        NavigationStack {
            VStack {Text("Sounds")
                    .font(.title)
                    .fontWeight(.bold)
                //title of the page
                
                Picker("in what category are you?", selection: $category) {
                    Text("Sounds").tag(0)
                    Text("Music").tag(1) }
                .pickerStyle(.segmented)
                .frame(width: 200)
                .padding()
                //segmented picker
                
               
                List {
                        ForEach(datas.sounds) { sound in
                            
                            HStack  {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 40)
                                    .foregroundStyle(sound.color)
                                    .padding(.trailing)
                                VStack (alignment: .leading)
                                {
                                    Text(sound.name)
                                        .font(.headline)
                                        .fontWeight(.medium)
                                    Text(sound.tag)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .swipeActions (edge:.trailing, allowsFullSwipe: false) {
                                
                                Button(role: .destructive) {
                                    print("Deleting conversation")
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                            .swipeActions (edge:.leading, allowsFullSwipe: false) {
                                
                                Button {
                                print("Edit screen")
                                } label: {Label("Edit", systemImage: "slider.vertical.3")
                                        .tint(.green)
                                    }
                             }
                            
                        }
                }
                .listStyle(.plain)
                .padding()
                
                
                
                HStack {
                    
                    customButton (buttonImage: "mic")
                    customButton (buttonImage: "paperclip")
                    
                    
                }
                
                
                
            }
       }
    }
}
    
    
    
    #Preview {
        LibraryView()
    }

