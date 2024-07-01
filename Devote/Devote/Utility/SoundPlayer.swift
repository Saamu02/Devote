//
//  SoundPlayer.swift
//  Devote
//
//  Created by Ussama Irfan on 02/07/2024.
//

import AVFoundation

var player: AVAudioPlayer?

func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        
        } catch {
            print("Could not find and play the sound file.")
        }
    }
}
