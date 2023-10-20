//
//  MorphEditScreen.swift
//  Morph
//
//  Created by Giorgio Caiazzo on 20/10/23.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var soundSpeed = 2
    @State private var soundPitch = 2
    @State private var soundName = ""
    @State private var soundTag = ""
    @State private var soundPreview = 0.3
    @State private var showPopUp = false
    
    
    var body: some View {
        
        VStack {
            
            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    Image(systemName: "plus.app.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150)
                                        .foregroundStyle(.gray)
                                }
                                .onChange(of: selectedItem) { newItem in
                                    Task {
                                        // Retrive selected asset in the form of Data
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            selectedImageData = data
                                        }
                                    }
                                }

                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                        }
            
            HStack {
                
                Button(action: {}, label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(.blue)
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
            }
            
            Button(action: {
                
                showPopUp = true
                
            }, label: {
                Image (systemName: "square.and.arrow.down.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }) .padding(.top)
            
            
        } .sheet(isPresented: $showPopUp, content: {
            Text ("Save")
        })
        .padding()
    }
}

#Preview {
    ContentView()
}

