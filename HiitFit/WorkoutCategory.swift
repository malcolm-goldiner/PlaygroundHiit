//
//  WorkoutCategory.swift
//  HiitFit
//
//  Created by Malcolm Goldiner on 3/10/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation


class WorkoutCategory {
    var categoryName : String = ""
    var exercises : [Workout] = []
    var categoryDes : String = ""
    
    var description: String {
        return self.categoryName
    }
    
  
    
}
