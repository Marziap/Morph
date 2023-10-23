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
    
    func submit() {
        print("You entered \(name)")
    }
    
    
    var body: some View {
        VStack {
            Text("Mixing")
                .font(.largeTitle)
                .padding(.bottom, 50)
            HStack{
                 
                if(!sounds.isEmpty){
                        Image(systemName: "play")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(.green)
                            .padding(.horizontal)
                    }
                
                ForEach(sounds) { sound in
                
                    ZStack {
                        /*Rectangle()
                            .frame(height: 30)
                            .foregroundColor(.black)*/
                        
                        Rectangle()
                            .frame(height: 30)
                        .foregroundColor(sound.color)
                    }
                    
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
                }.onMove(perform: move)

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
    }
}


#Preview {
    MixingView()
}
