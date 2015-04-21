//
//  BodyMeasurementsViewController.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 2/28/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit

class BodyMeasurementsViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    
    
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var datesPicker: UIDatePicker!
    @IBOutlet weak var unitsButton: UIButton!
    @IBOutlet weak var unitsPickerView: UIPickerView!
    
    @IBOutlet weak var weightChart: Chart!
    
    var date = NSDate()
    var weight = 0
    var units = "pounds"
    var justChanged = false
    let unitOptions = ["lbs","kgs"]
    let offset = 4

     func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
     func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.unitOptions.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.unitOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.units = self.unitOptions[row]
        
    }
    
    
    
    @IBAction func unitsButtonPressed(sender: AnyObject) {
        
        if(!self.unitsPickerView.hidden && self.weightTextField!.text != nil
            && count(self.weightTextField!.text!) > 2 && self.units != self.unitOptions[self.unitsPickerView.selectedRowInComponent(0)]){
                self.units = self.unitOptions[self.unitsPickerView.selectedRowInComponent(0)]
                
                var pounds : Float = 0.0
                var newWeight : Float = 0.0
                if(self.units == "lbs" && justChanged){
                    self.weightTextField.placeholder = "lbs"
                    justChanged = false
                    print(self.weightTextField!.text!.substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, -self.offset))))
                    pounds  =   Float(self.weightTextField!.text!.substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, -self.offset))).toInt()!)
                    newWeight = pounds * 2.20462
                    
                } else if(self.units == "kgs" && justChanged){
                    self.weightTextField.placeholder = "kgs"
                    justChanged = false
                    print(self.weightTextField!.text!.substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, -self.offset))))
                    pounds  =   Float(self.weightTextField!.text!.substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, -self.offset))).toInt()!)
                    newWeight = pounds * 0.453592
                } else {
                    newWeight = Float(self.weightTextField!.text!.toInt()!)
                }
                
                self.weightTextField!.text! = "\(newWeight) "
                
                self.weightTextField!.text! = self.weightTextField!.text!.stringByAppendingString(self.unitOptions[self.unitsPickerView.selectedRowInComponent(0)])
                justChanged = false
        } else {
            justChanged = true
        }
        self.unitsPickerView.hidden = !self.unitsPickerView.hidden
        self.weightChart.hidden = !self.weightChart.hidden
        self.units = self.unitOptions[self.unitsPickerView.selectedRowInComponent(0)]
        self.changeGraphUnits()
        
        
    }
    
    override func viewDidLoad() {
        self.weightTextField!.placeholder? = self.unitOptions[self.unitsPickerView.selectedRowInComponent(0)]
        self.title = "Weight Tracker"
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if((defaults.objectForKey(self.weightTextField!.text!)) != nil){
            self.weightTextField!.text! = (defaults.objectForKey("HiitFit") as! String).substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, -self.offset)))
            self.units = (defaults.objectForKey("HiitFit") as! String).substringWithRange(Range<String.Index>(start:  advance(self.weightTextField!.text!.endIndex, -self.offset), end: self.weightTextField!.text!.endIndex))
            self.unitsPickerView.selectedRowInComponent((self.units == "kgs") ? 1 : 0)
            self.date = defaults.objectForKey("HiitFitDate")as! NSDate
            self.datesPicker.setDate(self.date, animated: true)
        }
        
        self.addSavedMeasurementsToChart(0)
        self.weightTextField.setNeedsDisplay()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        var weight = Float(self.weightTextField!.text!.substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, -self.offset))).toInt()!)
        if(self.units == "kilograms"){
            weight /= 2.20462
        }
        
        self.addSavedMeasurementsToChart(weight)
        
        return true
    }
    
    func changeGraphUnits()
    {
        
        self.weightChart.removeSeries()
        if(self.units == "kgs"){
            var defaults = NSUserDefaults.standardUserDefaults()
            
            var copyOfDefaults = NSMutableArray()
            
            var pastPoints : [[Float]] = []
            
            var points : Array<(x: Float, y: Float)> = []
            
            
            if(defaults.objectForKey("PastHiit") != nil){
                
                print(defaults.objectForKey("PastHiit") )
                
                pastPoints = defaults.objectForKey("PastHiit")! as! [[Float]]
                
                
                
                for var i = 0; i < count(pastPoints); ++i{
                    var thisSet : [Float] = pastPoints[i] as
                        [Float]
                    copyOfDefaults.addObject(thisSet)
                    
                    thisSet[1] *= 0.453592
                    
                    
                    
                    let point : Array<(x: Float, y: Float)> = [(x: Float(thisSet[0]), y: Float(thisSet[1]))]
                    
                    points.append(x:Float(thisSet[0]), y:Float(thisSet[1]))
                    
                    
                    
                }
            }
            
            var series = ChartSeries(data: points)
            
            
            
            self.weightChart.addSeries(series)
            self.weightChart.setNeedsDisplay()
            
        }
        else{
           self.addSavedMeasurementsToChart(0)
        }
    }
    
    
    
    
    func addSavedMeasurementsToChart(weight: Float)
    {
        var defaults = NSUserDefaults.standardUserDefaults()
        
        var copyOfDefaults = NSMutableArray()
        
        var pastPoints : [[Float]] = []
        
        var points : Array<(x: Float, y: Float)> = []
        
        
        if(defaults.objectForKey("PastHiit") != nil){
            
            print(defaults.objectForKey("PastHiit") )
            
            pastPoints = defaults.objectForKey("PastHiit")! as! [[Float]]
            
            
            
            for var i = 0; i < count(pastPoints); ++i{
                var thisSet : [Float] = pastPoints[i] as [Float]
                copyOfDefaults.addObject(thisSet)
                
                
                
                
                let point : Array<(x: Float, y: Float)> = [(x: Float(thisSet[0]), y: Float(thisSet[1]))]
                
                points.append(x:Float(thisSet[0]), y:Float(thisSet[1]))
                
                
                
            }
        }
        
        /*
        if(points.count > 0) {
            var series = ChartSeries(data: points)
            
            
            
            self.weightChart.addSeries(series)
            
        }*/
        
        var counter =  count(pastPoints)
        
        var array = NSMutableArray()
        
        
        //var weight = Float(self.weightTextField!.text!.substringWithRange(Range<String.Index>(start:  self.weightTextField!.text!.startIndex, end: advance(self.weightTextField!.text!.endIndex, - offset))).toInt()!)
        if(weight != 0){
            points.append(x: Float(counter), y: weight)
            let point : Array<(x: Float, y: Float)> = [(x: Float(counter), y: weight)]
            
            var series = ChartSeries(data: points)
            
            copyOfDefaults.addObject([counter,weight])
            
            defaults.setObject(copyOfDefaults, forKey: "PastHiit")
            defaults.synchronize()
            
            self.weightChart.addSeries(series)
        } else if(points.count != 0) {
            var series = ChartSeries(data: points)
            
            
            
            self.weightChart.addSeries(series)
        }
        
        
        self.weightChart.setNeedsDisplay()
        
        
        
    }
    
    
    
    @IBAction func newDatePicked(sender: UIDatePicker) {
        self.date = sender.date
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(self.date, forKey: "HiitFitDate")
        userDefaults.synchronize()
    }
    
    
    @IBAction func weightTextChanged(sender: UITextField) {
        if(count(self.weightTextField!.text!) > 0){
            self.weightTextField!.text! += " \(self.unitOptions[self.unitsPickerView.selectedRowInComponent(0)])"
            
            self.weightTextField.setNeedsDisplay()
            
            var userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setValue(self.weightTextField!.text!, forKey: "HiitFit")
            userDefaults.synchronize()
        }
    }
    
    
    @IBAction func pressedCalendarButton(sender: AnyObject) {
        self.datesPicker.hidden = !self.datesPicker.hidden
    }
    
    
    
    
}
