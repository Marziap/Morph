//
//  ContentView.swift
//  MorphEditScreen
//
//  Created by Giorgio Caiazzo on 19/10/23.
//

import SwiftUI
import PhotosUI

struct EditMusicView: View {
    
    @State private var color = Color.green
    @State private var soundSpeed = 2
    @State private var soundPitch = 2
    @State private var soundName = ""
    @State private var soundTag = ""
    @State private var soundPreview = 0.3
    @Environment(Datas.self) private var datas
    @State private var showingAlert = false
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var music: Music
    
    
    
    var body: some View {
        
        ScrollView {
            
            ZStack {
                Image(systemName: "music.quarternote.3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                .foregroundStyle(color)
                
                ColorPicker("", selection: $color, supportsOpacity: false)
                    .offset(x: -70)
            }
            
            
            

            HStack {
                
                Button(action: {}, label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    .padding()
                })
                
                
                
                Slider(value: $soundPreview)
                    .padding(.trailing)
                }
            
            HStack {
                
                Text("Name")
                    .font(.title2)
                    .padding()
                TextField("Insert name", text: $soundName)
                
            }
            
            Rectangle ()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding (.horizontal)
                .offset(y:-15)
            
            HStack {
                
                Text("Tags")
                    .font(.title2)
                    .padding()
                TextField("Insert tag", text: $soundTag)
            }
            
            Rectangle ()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding (.horizontal)
                .offset(y:-15)
            
            VStack (alignment: .leading) {
                Text ("Speed")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Picker(selection: $soundSpeed, label: Text("Picker")) {
                    Text("0.5x").tag(1)
                    Text("1x").tag(2)
                    Text("1.5x").tag(3)
                    Text("2x").tag(4)
                    
                } .pickerStyle(.segmented)
                    .padding(.bottom)
                
                Text ("Pitch")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Picker(selection: $soundPitch, label: Text("Picker")) {
                    Text("-1/2").tag(1)
                    Text("0").tag(2)
                    Text ("+1/2").tag(3)
                } .pickerStyle(.segmented)
                    .padding(.bottom)
            }.padding()
            
            Button(action: {
                
                showingAlert = true
                
            }, label: {
                Image (systemName: "square.and.arrow.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }) .padding(.top)
            
            
        }
        .onAppear{
            color=music.color
            soundName=music.name
            soundTag=music.tag
        }
        .alert("Do you want to Keep it?", isPresented: $showingAlert) {
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            })
            
            Button {
                music.name=soundName
                music.tag=soundTag
                music.color=color
            } label: {
                Text("Save")
            }

            
            
            Spacer()
            
        }
        
    }
}
