//
//  RecordingFunc.swift
//  Morph
//
//  Created by Giorgio Caiazzo on 24/10/23.
//

import Foundation
import AVFoundation

class VoiceViewModel : NSObject , ObservableObject , AVAudioPlayerDelegate {
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    @Published var isRecording : Bool = false
    
    @Published var recordingsList = [Sounds]()
    
    
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

        let fileName = path.appendingPathComponent("CO-Voice : (dateString).m4a")
        
        
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
    }
    
    
    func stopRecording(){
        audioRecorder.stop()
        isRecording = false
    }
    
}

var musicRecording = VoiceViewModel ()

func fetchAllRecording(){
        
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

    for i in directoryContents {
        datas.sounds.append(Sounds(/*fileURL : i, */isPlaying: false))
    }
        
        
}
