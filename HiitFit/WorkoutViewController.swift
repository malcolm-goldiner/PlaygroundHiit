//
//  WorkoutViewController.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 2/28/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import UIKit
import Foundation


class WorkoutViewController : UIViewController{
    var workoutName = ""
    var startImage = UIImage()
    var endImage = UIImage()
    var timer = SWViewController()
    var loadingInd = UIActivityIndicatorView()
    
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var endImageView: UIImageView!
    
    
    @IBAction func startPressed(sender: AnyObject) {
        timer.start(sender)
        timer.duration = 45
    }
    
    
    @IBAction func stopPressed(sender: AnyObject) {
        timer.stop(sender)
    }
    
    override func viewDidLoad() {
        
        
        
        self.navigationItem.title = self.workoutName
        self.startImageView?.image = self.startImage
        self.endImageView?.image = self.endImage
        
        
        
        var imageSpaceRect = CGSize()
        
        imageSpaceRect.height = (self.startLabel.frame.origin.y + 8) - (self.view.frame.origin.y + 8)
        imageSpaceRect.width = self.view.frame.size.width - 16
        
        self.startImageView.frame.size = imageSpaceRect
        
        self.startImageView?.contentMode = .ScaleAspectFit
        self.endImageView?.contentMode = .ScaleAspectFit
        
        
        self.view.setNeedsDisplay()
        self.timer.displayTimeLabel = self.timerLabel
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            while(self.startImageView.image == nil){
                
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.startImageView.setNeedsDisplay()
                self.endImageView.setNeedsDisplay()
            }
        }
    }
    
}