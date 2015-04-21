//
//  HiitFitOutterTableView.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 2/17/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit




class HiitFitOutterTableView : UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var workoutCats : [WorkoutCategory] = []
    
    var currentSeletedCell : Int?
    
    var formedDestination = HiitFitInnerTableView()
    
    var loadingInd = UIActivityIndicatorView()
    
    
    internal func setWoroutCats(w: [WorkoutCategory] ) {
        self.workoutCats = w
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadInputViews()
        if self.workoutCats.count == 0 {
            var loader = WorkoutPopulator()
            self.workoutCats = loader.setup()
        }
       
        
       
        
        self.navigationItem.title = "Exercises"
       
    }
    
    
    
  
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutCats.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text =  self.workoutCats[indexPath.row].categoryName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
          self.currentSeletedCell = indexPath.row
        
        self.view.addSubview(self.loadingInd)
        self.loadingInd.frame = CGRectMake(self.view.center.x - self.loadingInd.frame.size.width, self.view.center.y - self.loadingInd.frame.size.height, self.loadingInd.frame.size.width, self.loadingInd.frame.size.height)
        self.view.setNeedsDisplay()
        
        
        self.loadingInd.color = UIColor.blackColor()
        self.loadingInd.hidden = false
        self.loadingInd.startAnimating()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.formedDestination.sectionName = (self.tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text!)!
            self.formedDestination.workouts = self.workoutCats[self.currentSeletedCell!].exercises
        
            for workout in self.formedDestination.workouts {
                
                
                workout.setImage()
            }
            

            dispatch_async(dispatch_get_main_queue()) {
                
                self.loadingInd.stopAnimating()
                self.loadingInd.hidden = true
                self.performSegueWithIdentifier("showSubCategories", sender: self.tableView.cellForRowAtIndexPath(indexPath));
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSubCategories" {
            var dest =  segue.destinationViewController as! HiitFitInnerTableView
            if sender?.textLabel??.text != nil {
                dest.sectionName = self.formedDestination.sectionName
                dest.workouts = self.formedDestination.workouts
            }
            
        }
    }
    
}
