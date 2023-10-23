//
//  ContentView.swift
//  MorphEditScreen
//
//  Created by Giorgio Caiazzo on 19/10/23.
//

import SwiftUI
import PhotosUI

struct MorphEditScreen: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var soundSpeed = 2
    @State private var soundPitch = 2
    @State private var soundName = ""
    @State private var soundTag = ""
    @State private var soundPreview = 0.3
    
    @State private var showingAlert = false
    @State private var name = ""
    @State private var tags = ""
    
    func submit() {
        print("You entered \(name)")
    }
    
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
                            .foregroundStyle(Color.gray)
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
            }.padding()
            
            Button(action: {
                
                showingAlert = true
                
            }, label: {
                Image (systemName: "square.and.arrow.down.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }) .padding(.top)
            
            
        } .alert("Do you want to Keep it?", isPresented: $showingAlert) {
            /*TextField("Name", text: $name)
            TextField("Tags", text: $tags)*/
            Button("Cancel", action: submit)
            Button("Save", action: submit)
                .foregroundStyle(Color.green)
        }
    }
}


#Preview {
    MorphEditScreen()
}
