//
//  HiitFitInnerTableView.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 2/17/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit



class HiitFitInnerTableView : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sectionName: String = ""
    
    @IBOutlet weak var startRoutineButton: UIButton!
    
    var workouts : [Workout] = []
    
    internal func setWorkoutCats(var input:Array<Workout>){
        self.workouts = input;
    }
    
    override func viewDidLoad() {
        self.reloadInputViews()
        self.navigationItem.title = self.sectionName
        
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var descTextView = UITextView()
        descTextView.scrollEnabled = false
        
        
        switch(self.sectionName){
        case("Warmups"):
            descTextView.text = "Exercises that help your muscles get prepared for a more rigorous physical activity to prevent injury."
            descTextView.frame.size = CGSizeMake(self.view.frame.size.width,50)
        case("Upper Body"):
            descTextView.text = "Increases strength of your upper body muscles which include your shoulders, arms, chest, and back muscles.  These exercises also increase the strength of the joints associated with those muscles which include the shoulder, elbow, and wrist joints."
            descTextView.frame.size = CGSizeMake(self.view.frame.size.width,80)
        case("Lower Body"):
            descTextView.text = "Increases the strength of the lower body muscles which include your gluteus, hamstrings, quadriceps, and calves.  These exercises also strengthen the joints associated with these muscles which include the hip, knee, and ankle joints."
            descTextView.frame.size = CGSizeMake(self.view.frame.size.width,80)
        case("Core"):
            descTextView.text = "These exercises improve your balance and stability by training your muscles in your hips, pelvis, lower back, and abdomen to work in unity.  Exercises for the core muscles aid in their ability to transfer force from one extremity to another."
            descTextView.frame.size = CGSizeMake(self.view.frame.size.width,80)
        case("Cardio/Plyometrics"):
            descTextView.text = "These exercises raise your heart rate increasing the strength of the larger muscle groups, but more importantly the heart muscle itself. Increasing the strength of your cardiovascular system will help the capillaries deliver oxygen more efficiently to the cells within the muscles to help in fat burning. Plyometric movements are a more ballistic movement that increases your balance and agility while in increasing the strength of the larger muscle groups as well."
            descTextView.frame.size = CGSizeMake(self.view.frame.size.width,115)
        case("Cool Downs/Stretches"):
            descTextView.text = "These exercises reduce the intensity of the previous endurance activities lowering your heart rate at a safe pace.  Abruptly stopping an intense exercise without cooling it down can cause your blood to pool in your legs resulting in dizziness and fainting."
            descTextView.frame.size = CGSizeMake(self.view.frame.size.width,80)
        default:
            return nil
            
        }
        
        var headerView = UIView()
        
        headerView.addSubview(descTextView)
        
        descTextView.textColor = UIColor.grayColor()
        
        
        
        
        var realSize = descTextView.textContainer.size
        
        
        
        headerView.frame.size = CGSizeMake(self.view.frame.size.width,  descTextView.frame.size.height)
        
        return headerView;
    }
    
    
    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        switch(self.sectionName){
        case("Warmups"):
            return 50
        case("Cardio/Plyometrics"):
            return 115
        case("Cool Downs/Stretches"):
            return 80
        case(""):
            return 0
        default:
            return 80
        }
    }
    
    
    @IBAction func startRoutineButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("startRoutine", sender: sender)
    }
    
    func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String!?{
            return self.sectionName
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = self.workouts[indexPath.row].name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showExerciseDetails" {
            let dest = segue.destinationViewController as! WorkoutViewController
            dest.workoutName = (sender?.textLabel??.text)!
            
            var cell = sender as! UITableViewCell
            var index = self.tableView!.indexPathForCell(cell)
            
            dest.startImage = self.workouts[index!.row].startImage
            dest.endImage = self.workouts[index!.row].endImage
        } else if (segue.identifier == "startRoutine"){
            let dest = segue.destinationViewController as! RoutinesViewController
            dest.exercises = self.workouts
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showExerciseDetails", sender: self.tableView .cellForRowAtIndexPath(indexPath));
        
    }
    
}