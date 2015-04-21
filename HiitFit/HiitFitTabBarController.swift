//
//  HiitFitTabBarController.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 2/28/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit

class HiitFitTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        
        self.viewControllers![0].tabBarItem!.title! = "Exercises"
        self.viewControllers![0].tabBarItem!.image =  UIImage(named:"exerciseIcon")!
        self.viewControllers![1].tabBarItem!.title! = "Custom Workout"
        self.viewControllers![1].tabBarItem!.image = UIImage(named:"customIcon")
        self.viewControllers![2].tabBarItem!.title! = "Programmed Workouts"
        self.viewControllers![2].tabBarItem!.image = UIImage(named: "preprogrammed")
        self.viewControllers![3].tabBarItem!.title! = "Body Measurements"
        self.viewControllers![3].tabBarItem!.image = UIImage(named:"measurements")
    }
    
}
