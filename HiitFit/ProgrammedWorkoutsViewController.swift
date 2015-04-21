//
//  ProgrammedWorkoutsViewController.swift
//  PlaygroundHiit
//
//  Created by Malcolm Goldiner on 4/4/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit

class ProgrammedWorkoutsViewController : UIViewController {
    
    @IBOutlet weak var greenieParentInfoButton: UIButton!
    @IBOutlet weak var fitnessEnthusiastButton: UIButton!
    @IBOutlet weak var woundedParentInfoButton: UIButton!
    @IBOutlet weak var transitionalParentInfoButton: UIButton!
    
    var workoutNeeded : String?
    var poulator : WorkoutPopulator = WorkoutPopulator()
    var currentTableViewData : WorkoutCategory = WorkoutCategory()
    
    var formedDestination = HiitFitInnerTableView()
    
    var loadingInd = UIActivityIndicatorView()
    
    
    
    func setImages(){
        
        self.view.addSubview(self.loadingInd)
        self.loadingInd.frame = CGRectMake(self.view.center.x - self.loadingInd.frame.size.width,self.view.center.y - self.loadingInd.frame.size.height, self.loadingInd.frame.size.width, self.loadingInd.frame.size.height)
        
        self.loadingInd.color = UIColor.blackColor()
        self.loadingInd.hidden = false
        self.loadingInd.startAnimating()
        
        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            
            
            for workout in self.currentTableViewData.exercises {
                workout.setImage()
            }
            
            
            
            
            dispatch_async(dispatch_get_main_queue()) {
                self.formedDestination.workouts = self.currentTableViewData.exercises
                if(self.currentTableViewData.categoryName == "GreenieParent"){
                    self.performSegueWithIdentifier("showGreenieParent", sender: nil)
                }
                else {
                    self.performSegueWithIdentifier("wounded", sender: nil)
                }
                self.loadingInd.stopAnimating()
                self.loadingInd.hidden = true
            }
        }
        
        
    }
    
    @IBAction func woundedPressed(sender: UIButton) {
        var arr = self.poulator.presetWorkouts["Wounded Parent"] as! [String]
        var cat = WorkoutCategory()
        cat.categoryName = "Wounded Parent"
        self.currentTableViewData = cat
        for string in arr{
            var w = Workout()
            w.name = string
            self.currentTableViewData.exercises.append(w)
        }
        self.setImages()
        var button = UIButton()
        button.titleLabel?.text = "Wounded Parent"
    }
    
    @IBAction func greeniePressed(sender: AnyObject) {
        var arr = self.poulator.presetWorkouts["Greenie Parent"] as! [String]
        var cat = WorkoutCategory()
        cat.categoryName = "Greenie Parent"
        self.currentTableViewData = cat
        for string in arr{
            var w = Workout()
            w.name = string
            self.currentTableViewData.exercises.append(w)
        }
        
        self.setImages()
        var button = UIButton()
        button.titleLabel?.text = "Greenie Parent"
    }
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    
        
        if( segue.identifier == "wounded"){
            var dest = segue.destinationViewController as! HiitFitInnerTableView
            dest.workouts = self.currentTableViewData.exercises
        } 
    }
    
    
    
    
    
}