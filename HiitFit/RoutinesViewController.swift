//
//  RoutinesViewController.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 3/10/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit

class RoutinesViewController : UIViewController {
    var exercises : [Workout] = []
    let restDuration = 15
    let repDuration = 45
    var startTime = NSTimeInterval()
    var timer = SWViewController()
    var lastChange : UInt8 = 0
    
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var currentLabel: UILabel!
    
    @IBOutlet weak var nextLabel: UILabel!
    
    @IBOutlet weak var currentExerciseImageView: UIImageView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var countdownProgressView: UIProgressView!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func startPressed(sender: AnyObject) {
        timer.start(sender)
    }
    
    
    @IBAction func stopPressed(sender: AnyObject) {
        timer.stop(sender)
    }
    
    override func viewDidLoad(){
        
        self.currentExerciseImageView.contentMode = .ScaleAspectFit
        
        
        self.timer.displayTimeLabel = self.countdownLabel
        var newEx : [Workout] = []
        
        for var i = 0 ; i < self.exercises.count - 1; i++ {
            newEx.append(self.exercises[i])
            if(i != self.exercises.count - 1){
                let rest = Workout()
                rest.name = "Rest"
                newEx.append(rest)
            }
            else {
                let cool = Workout()
                cool.name = "Cool Down"
                newEx.append(cool)
            }
        }
        
        
        self.exercises = newEx
        
        
        self.beginWorkoutAtIndex(0)
    }
    
    func beginWorkoutAtIndex(startingIndex: Int){
        
        
        
        self.currentLabel.text = self.exercises[startingIndex].name
        self.currentExerciseImageView.image = self.exercises[startingIndex].startImage
        
        if(startingIndex%2 != 0){
            
            self.timer.duration =  restDuration
        
            
        } else {
            self.timer.duration = repDuration
        }
        
        
        
        if((startingIndex + 1) < self.exercises.count){
            self.nextLabel!.text = "Next Exercise: " + self.exercises[startingIndex + 1].name
        }
        self.timer.start(self.startButton)
        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            
            while(self.timer.valid){
                if(self.timer.currentSeconds != self.lastChange && self.timer.currentSeconds%(5 as UInt8) == 0 && self.timer.currentSeconds > (0 as UInt8)){
                    self.lastChange = self.timer.currentSeconds
                    dispatch_async(dispatch_get_main_queue()) {
                        if(self.currentExerciseImageView.image == self.exercises[startingIndex].startImage){
                            self.currentExerciseImageView.image = self.exercises[startingIndex].endImage
                            self.imageLabel.text = "End Image"
                        } else {
                            self.currentExerciseImageView.image = self.exercises[startingIndex].startImage
                            self.imageLabel.text = "Start Image"
                        }
                        
                        
                        
                       
                        
                        self.view.setNeedsDisplay()
                        
                    }
                    
                }
                
            }
            
            if((startingIndex + 1) < (self.exercises.count)){
                dispatch_async(dispatch_get_main_queue()) {
                    self.beginWorkoutAtIndex(startingIndex + 1)
                    
                }
                
            }
            
        }
    }
}




