//
//  LibraryView.swift
//  Morph
//
//  Created by Katharina Brutscher on 20/10/23.
//

import SwiftUI

struct LibraryView: View {
    @State private var category = 0
    @State private var title = "Sounds"
    //for the segmented picker
    @State private var record = false
    @State private var showSettings = false
    @Environment(Datas.self) private var datas
    @State private var showPopUp = false
    @State private var name = ""
    @State private var tags = ""
    @State private var timeRemaining = 0
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) private var dismiss
    var musicRecording = VoiceViewModel ()
    var animation: Animation {
        return .linear(duration: 0.5).repeatForever()
    }
    
    func fetchLastRecording(name: String, tags: String, color: Color){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        //sort
        let sortedContents = directoryContents.sorted { url1, url2 in
                return url1.lastPathComponent < url2.lastPathComponent
            }
        
        let i = sortedContents.last
        datas.sounds.append(Sound(name : name, tag: tags, color: .blue, fileURL: i!))
        
    }
    
    
    func deleteRecordingFile(sound: Sound) {
        let fileManager = FileManager.default

        do {
            print("fileURL da eliminare: \(sound.fileURL)")
            try fileManager.removeItem(at: sound.fileURL)
            datas.sounds.removeAll { $0.id == sound.id }
            print("file deleted")
        } catch {
            print("Error deleting file: \(error)")
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("directoryContent: \(directoryContents)")
        }
    }
    
    func emptyDirectory(atPath directoryPath: URL) {
        let fileManager = FileManager.default
        
        do {
            let contents = try fileManager.contentsOfDirectory(at: directoryPath, includingPropertiesForKeys: nil, options: [])
            for item in contents {
                try fileManager.removeItem(at: item)
            }
        } catch {
            print("Error emptying directory: \(error)")
        }
    }

    
    var body: some View  {
        
        NavigationStack {
            VStack {
                
                Picker("Category", selection: $category) {
                    Text("Sounds").tag(0)
                    Text("Music").tag(1)}
                .pickerStyle(.segmented)
                .frame(width: 200)
                .padding()
                //segmented picker
                
                
                if(category==0){
                    
                    List {
                            ForEach(datas.sounds) { sound in
                                
                                HStack  {
                                    Image(systemName: sound.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 40)
                                        .foregroundStyle(sound.color)
                                        .padding(.trailing) 
                                    
                                  /*  HStack {
                                        
                                        bar (low:0.4)
                                            .animation(animation.speed(1.4), value: musicRecording.audioPlayer.isPlaying)
                                        bar (low:0.3)
                                            .animation(animation.speed(1.2), value: musicRecording.audioPlayer.isPlaying)
                                        bar (low:0.7)
                                            .animation(animation.speed(1.0), value: musicRecording.audioPlayer.isPlaying)
                                        bar (low:0.5)
                                            .animation(animation.speed(1.5), value: musicRecording.audioPlayer.isPlaying)
                                        
                                        
                                    } .frame(width:40)
                                        .offset(x:-10) */
                                        
                                    
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
                                .onTapGesture {
                                    musicRecording.startPlaying(url: sound.fileURL)
                                }
                                .swipeActions (edge:.trailing, allowsFullSwipe: true) {
                                    
                                    Button(role: .destructive) {
                                       print("sound da eliminare \(sound.name)")
                                       deleteRecordingFile(sound: sound)
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                            .tint(.red)
                                    }
                                }
                                .swipeActions (edge:.leading, allowsFullSwipe: true) {
                                    
                                    NavigationLink (destination: EditSoundView(sound: sound)) {
                                        Button {
                                            //datas.selectedSound=sound
                                            print("Edit screen")
                                        } label: {Label("Edit", systemImage: "slider.vertical.3")
                                                .tint(datas.color)
                                        }
                                    }
                                }
                            
                            }
                        
                    
                    }.task {
                        title="Sounds"
                    }
                    .listStyle(.plain)
                    .padding()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            record.toggle()
                            
                            if (record == true) {
                                musicRecording.startRecording()
                            } else {
                                timeRemaining=0
                                showPopUp=true
                            }
                            
                        }, label: {
                            Image (systemName: "mic")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundStyle(record ? Color.red : datas.color)
                                .scaleEffect(record ? 1.2 : 1.0)
                      
                            
                        }).padding(.horizontal, 20)
                        
                        if(record==true){
                            Text("\(timeRemaining)")
                                .onReceive(timer) { time in
                                        timeRemaining += 1
                                }
                        }
                        
                        Spacer()
                        
                    } .padding(.bottom,30)
                       //Sounds View
                }else{
                    List {
                        ForEach(datas.music) { music in
                                
                                HStack  {
                                    Image(systemName: music.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 40)
                                        .foregroundStyle(music.color)
                                        .padding(.trailing)
                                    VStack (alignment: .leading)
                                    {
                                        Text(music.name)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        Text(music.tag)
                                            .font(.subheadline)
                                            .fontWeight(.light)
                                            .foregroundStyle(.gray)
                                    }
                                }
                                .onTapGesture {
                                    musicRecording.startPlaying(url: music.fileURL)
                                }
                                .swipeActions (edge:.trailing, allowsFullSwipe: true) {
                                    
                                    Button(role: .destructive) {
                                        print("Deleting music")
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                            .tint(.red)
                                    }
                                }
                                .swipeActions (edge:.leading, allowsFullSwipe: true) {
                                    
                                   NavigationLink (destination: EditMusicView(music: music)) {
                                        Button {
                                            print("Edit screen")
                                        } label: {Label("Edit", systemImage: "slider.vertical.3")
                                                .tint(datas.color)
                                        }
                                    }
                                }
                                
                            }
                    }
                    .task{
                        title="Music"
                    }
                    .listStyle(.plain)
                    .padding()
                }
               //Music View
  
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .task {
//                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                emptyDirectory(atPath: path)
            }
            .navigationTitle(title)
            
                        .toolbar {
                            Button {
                                showSettings=true
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 27)
                                    .foregroundStyle(datas.color)
            
                            }
            
                        }
            
            .alert("Do you want to Keep it?", isPresented: $showPopUp) {
                TextField("Name", text: $name)
                TextField("Tags", text: $tags)
                Button {
                    dismiss()
                } label: {
                    Text ("Cancel")
                }

                Button {
                    musicRecording.stopRecording()
                    fetchLastRecording(name: name, tags: tags, color: .blue)
                    name=""
                    tags=""
                } label: {
                    Text ("Save")
                }

            }.tint(datas.color)
        }
            
    }
    
   /* func bar(low: CGFloat = 0.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(.indigo.gradient)
            .frame(height: (musicRecording.audioPlayer.isPlaying ? high : low) * 40)
            .frame(height: 40, alignment: .center)
    } */
    
}
