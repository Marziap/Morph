//
//  MixingView.swift
//  ProvaMusic
//
//  Created by Marzia Pirozzi on 17/10/23.
//

import SwiftUI


struct MixingView: View {
    @State private var showModal = false
    @State private var showingAlert = false
    @Environment(Datas.self) private var datas
    @State private var name = ""
    @State private var tags = ""
    @Environment(\.dismiss) private var dismiss
    var musicRecording = VoiceViewModel ()
    
    func move(from source: IndexSet, to destination: Int) {
        datas.mixSounds.move(fromOffsets: source, toOffset: destination)
    }
    // funktion for drag and drop
   
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack{
                    
                    if(!datas.mixSounds.isEmpty){
                        Button(action: {

                        }, label: {
                            Image(systemName: "play")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundColor(datas.color)
                                .padding(.horizontal)
                        }).padding(.vertical)
                        
                    }
                    
                    //mixing view with sounds in it
                    
                    ForEach(datas.mixSounds) { sound in
                        
                        if(datas.sounds.contains(where: { aSound in
                            aSound.id==sound.id
                        })){
                            Rectangle()
                                .frame(height: 30)
                                .foregroundColor(sound.color)
                        }
                    }
                    
                }.padding(.horizontal)
                
                List{
                    ForEach(datas.mixSounds) { sound in
                        
                        if(datas.sounds.contains(where: { aSound in
                            aSound.id==sound.id
                        })){
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
                                    
                                    datas.mixSounds.removeAll { aSound in
                                        aSound.id==sound.id
                                    }
                                    
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                        .tint(.red)
                                }
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
                        .foregroundColor(datas.color)
                })
                .padding(.vertical, 50)
                //save sound/ trigger pop up
                
            }
            .sheet(isPresented: $showModal, onDismiss:{
                
            }, content: {
                ModalView()
            })
            .alert("Do you want to Keep it?", isPresented: $showingAlert) {
                TextField("Name", text: $name)
                TextField("Tags", text: $tags)
                
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Button {
                    datas.music.append(Music(name: name, tag: tags, color: .blue, fileURL: URL(string: "Ciao")!, sounds: datas.mixSounds))
                    
                    print("music: \(datas.music[0].sounds)")
                    name=""
                    tags=""
                    
                } label: {
                    Text("Save")
                }

            }
            //Save and name Popup
            
            .navigationTitle("Mixing")
            //            .toolbar {
            //                Button {
            //                    showModal=true
            //                } label: {
            //                    Image(systemName: "plus")
            //                        .resizable()
            //                        .aspectRatio(contentMode: .fit)
            //                        .frame(width: 27)
            //
            //                }
            //
            //            }
                    }
        }
    }



//#Preview {
//    MixingView()
//}
