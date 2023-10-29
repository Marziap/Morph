//
//  RecordingFunc.swift
//  Morph
//
//  Created by Giorgio Caiazzo on 24/10/23.
//

import SwiftUI
import Foundation
import AVFoundation

class VoiceViewModel : NSObject , ObservableObject , AVAudioPlayerDelegate {
    
   
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    @Published var isRecording : Bool = false
    @State private var datas = Datas()
    
    
    
    override init(){
        super.init()
    }
   
 
    func startRecording(){
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Can not setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YY 'at' HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())

        let fileName = path.appendingPathComponent("\(dateString).m4a")
        
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
            
        } catch {
            print("Failed to Setup the Recording")
        }
        
        
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        print("directoryContentStartRec: \(directoryContents), count: \(directoryContents.count)")
        
    }
    
    
    func stopRecording(){
        audioRecorder.stop()
        isRecording = false
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

        print("directoryContentStopRec: \(directoryContents), count: \(directoryContents.count)")
        
    }
    
    
    func startPlaying(url : URL) {
      
        let playSession = AVAudioSession.sharedInstance()
            
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
            
        do {
            audioPlayer = try AVAudioPlayer(contentsOf : url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
                
            for i in 0..<datas.sounds.count{
                if datas.sounds[i].fileURL == url{
                    datas.sounds[i].isPlaying = true
                }
            }
                
        } catch {
            print("Playing Failed")
        }
                
    }

    func stopPlaying(url : URL){
      
        audioPlayer.stop()
      
        for i in 0..<datas.sounds.count {
            if datas.sounds[i].fileURL == url {
                datas.sounds[i].isPlaying = false
            }
        }
      
    }
    
    
}
