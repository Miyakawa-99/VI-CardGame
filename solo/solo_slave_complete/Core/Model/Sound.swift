
//
//  sound.swift
//  karuta
//子
//  Created by miyakawa haruna on 2019/03/01.
//  Copyright © 2019年 miyakawa haruna. All rights reserved.
//

import Foundation
import AVFoundation

class Sound{
    var audioPlayer: AVAudioPlayer!
    func playSound(name: String){
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3")else{
            print("can't find file")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
 
        }catch{
            fatalError("Failed to initialize a player")
        }
    }
    func play(){
        self.audioPlayer.play()
    }
    func stop(){
        self.audioPlayer.stop()//error
    }
}

