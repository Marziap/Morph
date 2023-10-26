//
//  MixingView.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import SwiftUI


struct MixingView: View {
    @State private var sounds:[Sounds] = []
    @State private var showModal = false
    @State private var showingAlert = false
    @State private var name = ""
    @State private var tags = ""
    
    func move(from source: IndexSet, to destination: Int) {
            sounds.move(fromOffsets: source, toOffset: destination)
        datas.mixSounds=sounds
    }
    // funktion for drag and drop
    func submit() {
        print("You entered \(name)")
    }
    // save to device
   
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack{
                    
                    if(!sounds.isEmpty){
                        Button(action: {
                            //play
                        }, label: {
                            Image(systemName: "play")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundColor(.green)
                                .padding(.horizontal)
                        }).padding(.vertical)
                        
                    }
                    
                    //mixing view with sounds in it
                    
                    ForEach(sounds) { sound in
                        
                            Rectangle()
                                .frame(height: 30)
                                .foregroundColor(sound.color)
                        
                    }
                    
                }.padding(.horizontal)
                
                List{
                    ForEach(sounds) { sound in
                        HStack {
                            Spacer()
                            Button {
                                print("sound played")
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(sound.color)
                                        .frame(width: 188, height: 30)
                                        .cornerRadius(10)
                                    
                                    Text(sound.name)
                                        .foregroundColor(.black)
                                }
                            }
                            Spacer()
                        }
                        .swipeActions (edge:.trailing, allowsFullSwipe: true) {
                            
                            Button(role: .destructive) {
                                print("Deleting music")
                                if let index = datas.mixSounds.firstIndex(of: sound) {
                                    datas.mixSounds.remove(at: index)
                                    sounds=datas.mixSounds
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                    }.onMove(perform: move)
                    // list of sounds that were added by user
                    
                }
                .listStyle(PlainListStyle())
                .frame(height: 300)
                .padding(.vertical, 40)
                
                Button {
                    showModal=true
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 188, height: 30)
                            .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                            .cornerRadius(10)
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
                //add sounds to list
                
                Button(action: {
                    showingAlert=true
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                        .foregroundColor(.green)
                })
                .padding(.vertical, 50)
                //save sound/ trigger pop up
                
            }
            .sheet(isPresented: $showModal, onDismiss:{
                sounds=datas.mixSounds
            }, content: {
                ModalView()
            })
            .alert("Do you want to Keep it?", isPresented: $showingAlert) {
                TextField("Name", text: $name)
                TextField("Tags", text: $tags)
                Button("Cancel", action: submit)
                Button("Save", action: submit)
            }
            //Save and name Popup
            
            .navigationTitle("Mixing")
        }
    }
}


#Preview {
    MixingView()
}
