//
//  CustomWorkoutViewController.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 3/10/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit


class CustomWorkoutViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var workoutOptionsTableView: UITableView!
    @IBOutlet weak var myWorkoutTableView: UITableView!
    @IBOutlet weak var backButtons: UIButton!
    @IBOutlet weak var workoutNameField: UITextField!
  
    var workoutCats : [WorkoutCategory] = [];
    var inSubCats : Bool = false
    var currentTableViewData :[AnyObject] = []
    var customWorkout : [Workout] = []
    
    var customCat : WorkoutCategory = WorkoutCategory()
    
     override func viewWillAppear(animated: Bool) {
        self.title = "Custom Workouts"
    }
    
    
    @IBAction func workoutNamed(sender: UITextField) {
        self.customCat.categoryName = sender.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func unpackStoredWorkouts(workout: [[String]]) -> [WorkoutCategory]
    {
        var unpackedCats : [WorkoutCategory] = []
        
        var i = 0
        for arr in workout {
            var unpackedCat : WorkoutCategory = WorkoutCategory()
            unpackedCat.categoryName = "custom \(i)"
            for name in arr{
                var unpackedWorkout = Workout()
                unpackedWorkout.name = name
                unpackedCat.exercises.append(unpackedWorkout)
            }
            unpackedCats.append(unpackedCat)
            i++
        }
        return unpackedCats
    }
    
    func getWorkoutCat() -> [WorkoutCategory]! {
        var cont = WorkoutPopulator()
        return cont.setup()
        
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.currentTableViewData = self.workoutCats
        self.inSubCats = false
        self.workoutOptionsTableView.reloadData()
        //self.workoutOptionsTableView.setEditing(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workoutCats = getWorkoutCat()
        
        self.currentTableViewData = self.workoutCats
        self.navigationItem.title = "Exercises"
        //self.workoutOptionsTableView.setEditing(true, animated: true)
        
    }
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) -> [AnyObject]! {
        
        let deleteClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            print(indexPath.row)
            self.customWorkout.removeAtIndex(indexPath.row)
            
            println("Delete closure called")
            self.myWorkoutTableView.editing = false
            self.myWorkoutTableView.reloadData()
        }
        
        let addClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            if(self.inSubCats) {
                print(indexPath.row)
                var newWorkout = Workout()
                newWorkout = self.currentTableViewData[indexPath.row] as! Workout
                
                if self.customWorkout.count == 0 && self.customCat.categoryName == "" {
                    self.customCat.categoryName = "custom"
                }
                
                self.customWorkout.append(newWorkout)
                self.customCat.exercises.append(newWorkout)
                
                
            }
            self.myWorkoutTableView.reloadData()
            self.workoutOptionsTableView.editing = false
            
            println("Delete closure called")
        }
        
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: deleteClosure)
        let addAction = UITableViewRowAction(style: .Normal, title: "Add", handler: addClosure)
        
        if(tableView == self.workoutOptionsTableView) {
            return [addAction]
            
        } else {
            return [deleteAction]
        }
        
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
    
    
    @IBAction func savePressed(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.valueForKey("CustomWorkouts") != nil {
            var current : [[String]] = defaults.valueForKey("CustomWorkouts") as! [[String]]
            var next : [String] = []
            for workout in self.customCat.exercises{
                next.append(workout.name)
            }
            current.append(next)
            defaults.setObject(current, forKey: "CustomWorkouts")
            defaults.setObject(self.customCat.categoryName, forKey:"\(current.count)Cat")
        } else {
            var arr : [[String]] = []
            var innerArr : [String] = []
            
            for workout in self.customCat.exercises{
                innerArr.append(workout.name)
            }
            arr.append(innerArr)
            
            defaults.setObject(self.customCat.categoryName, forKey:"1Cat")
            defaults.setObject(arr, forKey: "CustomWorkouts")
        }
        self.customCat = WorkoutCategory()
        self.customWorkout = []
        self.workoutNameField?.text = ""
        self.myWorkoutTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (tableView == self.workoutOptionsTableView) ? self.currentTableViewData.count : self.customWorkout.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(tableView == self.workoutOptionsTableView) {
            if(self.inSubCats){
                cell.textLabel?.text  = (self.currentTableViewData[indexPath.row] as! Workout).name
            }else{
                cell.textLabel?.text = (self.currentTableViewData[indexPath.row] as! WorkoutCategory).categoryName
            }
        } else{
            cell.textLabel?.text = self.customWorkout[indexPath.row].name
        }
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(tableView == self.workoutOptionsTableView && !self.inSubCats){
           
            self.currentTableViewData = self.workoutCats[indexPath.row].exercises
            self.inSubCats = true
            self.workoutOptionsTableView.reloadData()
            //self.workoutOptionsTableView.setEditing(self.currentTableViewData == self.workoutSubCats, animated: true)
        } else {
            self.workoutOptionsTableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: false)

            var newWorkout = Workout()
            newWorkout = self.currentTableViewData[indexPath.row] as! Workout
            
            if self.customWorkout.count == 0 && self.customCat.categoryName == "" {
                self.customCat.categoryName = "custom"
            }
            
            self.customWorkout.append(newWorkout)
            self.customCat.exercises.append(newWorkout)
            self.myWorkoutTableView.reloadData()
            

        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "showCustom"){
            return NSUserDefaults.standardUserDefaults().valueForKey("CustomWorkouts") != nil
        }
        return true
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSubCategories" && !self.inSubCats{
            var dest =  segue.destinationViewController as! HiitFitInnerTableView
            if sender?.textLabel??.text != nil {
                dest.sectionName = (sender?.textLabel??.text)!
                print (dest.sectionName)
            }
        } else if segue.identifier == "showCustom"{
            var destin = (segue.destinationViewController as! UINavigationController).topViewController as! HiitFitOutterTableView
            // need check here
            
           
            if(NSUserDefaults.standardUserDefaults().valueForKey("CustomWorkouts") != nil) {
                var data = NSUserDefaults.standardUserDefaults().valueForKey("CustomWorkouts") as! [[String]]
                
                destin.workoutCats = self.unpackStoredWorkouts(data)
                
                
                for i in 0...destin.workoutCats.count - 1{
                    destin.workoutCats[i].categoryName = NSUserDefaults.standardUserDefaults().valueForKey("\(i + 1)Cat") as! String
                }
            }
       
           
        }
        
    }
    
    
    
}