//
//  ViewController.swift
//  EggTimer
//
//  Created by Mauricio Chaves Dias on 01/03/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer!


class ViewController: UIViewController {


    @IBOutlet weak var softEggButton: UIButton!
    @IBOutlet weak var mediumEggButton: UIButton!
    @IBOutlet weak var hardEggButton: UIButton!
    @IBOutlet weak var softEggView: UIView!
    @IBOutlet weak var mediumEggView: UIView!
    @IBOutlet weak var hardEggView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTime = ["Soft" : 3, "Medium" : 420, "Hard" : 720]
    var totalTime = 0
    var secondsPassed = 0
    var timerInProgress = false
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        secondsPassed = 0
        timerInProgress = true
        titleLabel.text = hardness

        progressView.progress = 0
        updateButtons(sender)
        
        startTimer()
    }
    
    func reduceOpacityButtonPressed(withButtonTag: Int){
        switch withButtonTag {
        case 1: //soft button
            softEggView.alpha = 0.5
        case 2: //soft button
            mediumEggView.alpha = 0.5
        case 3: //soft button
            hardEggView.alpha = 0.5
        default:
           abort()
        }
    }
    
    func updateButtons(_ sender : UIButton?) {
        softEggView.alpha = 1
        mediumEggView.alpha = 1
        hardEggView.alpha = 1
        if sender != nil {
            reduceOpacityButtonPressed(withButtonTag: sender!.tag)
        }
        softEggButton.isEnabled = !timerInProgress
        mediumEggButton.isEnabled = !timerInProgress
        hardEggButton.isEnabled = !timerInProgress
    }
    
    
    //TIMER
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                self.progressView.progress = Float(self.secondsPassed) / Float(self.totalTime)
            } else {
                Timer.invalidate()
                self.timerInProgress = false
                self.titleLabel.text = "DONE!"
                self.playSound(soundName: "alarm_sound", extensionFile: "mp3")
                self.updateButtons(nil)
            }
        }
    }
    
    //PLAY THE SOUND OF THE ALARM
    func playSound(soundName: String, extensionFile: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: extensionFile)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play();
    }
}
