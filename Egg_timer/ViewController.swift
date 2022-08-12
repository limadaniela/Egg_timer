//
//  ViewController.swift
//  Egg_timer
//
//  Created by Daniela Lima on 2022-07-01.
//

import UIKit
import AVFoundation //to include sound when pressing a button

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720] //dictionary for egg times
    var timer = Timer() //to be used in countdown code
    var player: AVAudioPlayer! //to include sound when pressing a button
    var totalTime = 0 //to be used by progressBar for status update
    var secondsPassed = 0 //to be used by progressBar for status update

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() //to restart the timer everytime the button is pressed
        let hardness = sender.currentTitle! //set hardness to currentTitle
        totalTime = eggTimes[hardness]! //set timer based on button pressed
        
        progressBar.progress = 0.0 //to set the progressBar down to zero
        secondsPassed = 0 //set back down to zero
        titleLabel.text = hardness //reset the titleLabel so we're are able to see which hardness was selected
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        //to restart timer when the button is pressed, we store it in a var (timer) and invalidate it inside the @IBAction
        //timeInterval is 1.0 because we whant our app to update every second
        //selector calls the func we put in there when UIButton is pressed
        //set repeats as true because we need this timer to repeat after the first second
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime { //increase 1 sec and update progressBar until secondsPassed = totalTime which triggers the else statement
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else { //to stop timer and change label text to "DONE!"
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            //to play a sound when countdown timer ends
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}

