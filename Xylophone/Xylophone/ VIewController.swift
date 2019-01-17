//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{

    //var player: AVAudioPlayer?
    var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        
       /* print(sender.tag)
        if let soundURL = Bundle.main.url(forResource: "note\(sender.tag)", withExtension: "wav"){
            var mySound:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            AudioServicesPlaySystemSound(mySound)
        }*/
        let soundURL = Bundle.main.url(forResource: "note\(sender.tag)", withExtension: "wav")
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL!)
        }catch{
            print(error)
        }
        audioPlayer.play() \
    }
    
  

}

