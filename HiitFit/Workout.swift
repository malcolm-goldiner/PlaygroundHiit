//
//  Workout.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 3/10/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit

class Workout {
    
    var done : Bool = false
    var name : String = ""
    var seconds : Int = 0
    var workoutImage = UIImage()
    var workoutDesc : String = ""
    var startImage : UIImage = UIImage()
    var endImage : UIImage = UIImage()
    
    
    var description: String {
        return self.name
    }
    
    
    
    func addImageDataToUserDefault(startImagedata : NSData, endImageData: NSData, workoutName : String){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if(defaults.objectForKey("PHiitImages") == nil){
            var imageDict : [String:AnyObject] = NSDictionary() as! [String : AnyObject]  // image should be either NSData or empty
            imageDict.updateValue([startImagedata,endImageData], forKey: workoutName)
            let dataExample : NSData = NSKeyedArchiver.archivedDataWithRootObject(imageDict)
            
            defaults.setObject(dataExample, forKey: "PHiitImages")
            
        } else {
            let entry = defaults.objectForKey("PHiitImages") as! NSData
            var dictionary  = (NSKeyedUnarchiver.unarchiveObjectWithData(entry)! as! [String: AnyObject])
            
            dictionary.updateValue([startImagedata,endImageData], forKey: workoutName)
            let dataExample : NSData = NSKeyedArchiver.archivedDataWithRootObject(dictionary)
            defaults.setObject(dataExample, forKey: "PHiitImages")
        }
        defaults.synchronize()
    }
    
    
    var storedImages : [String:AnyObject]?
    
    
    func setImage(){
        
        print(self.name + " Start")
        
        
        let replacedString = self.name.stringByReplacingOccurrencesOfString("/", withString: ":")
        
        self.startImage = UIImage(named:replacedString + " Start")!
        self.endImage = UIImage(named: replacedString + " End")! 
        
           /*
        var startData = NSData()
        var endData = NSData()
        
        
        if(self.storedImages == nil){
            if(NSUserDefaults.standardUserDefaults().objectForKey("PHiitImages") != nil){
                self.storedImages = NSKeyedUnarchiver.unarchiveObjectWithData(NSUserDefaults.standardUserDefaults().objectForKey("PHiitImages") as! NSData) as? [String:AnyObject]
                if(self.storedImages![self.name] != nil) {
                    var array = self.storedImages![self.name] as! [NSData]
                    startData = array[0]
                    endData = array[1]
                }
            }
        }
        
        
        
     
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            
            
            var escapedString = "\(self.name) Start.png".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            //println("escapedString: \(escapedString)")
            
            
            var str = "http://www.malcolmgoldiner.com/developer/SP/"
            str += escapedString!
            
            
            var sURL = NSURL(string: str)
            
            
            
            if(NSData(contentsOfURL: sURL!) != nil) {
                startData = NSData(contentsOfURL: sURL!)!
                self.startImage = UIImage(data: startData)!
                
            }
            
            
            escapedString = "\(self.name) End.png".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            str = "http://www.malcolmgoldiner.com/developer/SP/"
            str += escapedString!
            
            sURL = NSURL(string: str)
            
            if(NSData(contentsOfURL: sURL!) != nil){
                endData = NSData(contentsOfURL: sURL!)!
                self.endImage = UIImage(data:endData)!
            }
            
            
            
            
            self.addImageDataToUserDefault(startData, endImageData: endData, workoutName: self.name)
            
            
            
            
            
            self.done = true*/
            
        }
    
        
    }
    
    
