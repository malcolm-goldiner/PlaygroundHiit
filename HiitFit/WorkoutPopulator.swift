//
//  WorkoutPopulator.swift
//  PlaygroundHiit
//
//  Created by Malcolm Goldiner on 3/28/15.
//  Copyright (c) 2015 Michylle Padillia. All rights reserved.
//

import Foundation
import UIKit

class WorkoutPopulator{
    
    
    
    let cats  = ["Warmups" : ["High Knee March", "Squat", "Arm Rotations", "Fluid Warrior", "Torso Twists","Up & Outs","Lateral Step/Pulls", "High Knee Pulls", "Lateral Swings", "Torso Twists (4) + Knee Up (1)", "Front Kicks", "Cross Toe Touches", "Cross Leg Swings", "Forward Head Roll"],"Core" : ["Bicycle Crunch","Crunch", "Sit Ups","Slide Sit Ups", "Back Extension", "Hanging Leg Raise", "Cat Cow", "Traditional Plank", "High Plank", "Side Plank", "Russian Twists", "Climbing Rope", "Standing Left Oblique Crunch", "Standing Right Oblique Crunch","Bridge", "Flutter Kicks", "Swing Flutter Kicks","Standing Knee Tuck Left","Standing Knee Tuck Right", "Sprinter Sit Up", "Contralateral Limb Raises", "Superman"],"Upper Body" : ["Back Extension","Traditional Push Up","Knee Push Ups", "Incline Bench Push Up", "Decline Bench Push Up", "Diamond Push Up", "Underhand Close Grip Pull Up", "Assisted Handstand Push Up", "Overhand Wide Grip Pull Up", "Dolphin Push Up", "Slide Dips", "Boxer", "Arm Circles"],"Lower Body" : ["Donkey Kicks","Wall Sits", "Front Lunge", "Reverse Lunge", "Curtsy Lunge", "Pistol Squat", "Deep Squats", "Left Leg Deadlift", "Right Leg Deadlift", "Chair Pose Squat","Bench Ups", "Calf Raises"],"Cardio/Plyometrics" : ["Inch Worm","Tuck Jump", "Bear Crawl", "Mountain Climber", "Incline Mountain Climber", "Plyometric Push Up", "Prone Walk Out", "Jumping Jacks", "Burpees", "Plank To Push Up","Lunge Jumps", "Squat Jumps", "Butt Kickers", "Skipping", "Hopping"],"Cool Downs/Stretches" : ["Cross Chest Arm Swings","Forward Lunge", "Glute Stretch", "Butterfly Stretch", "Hip Flexor With Calf Stretch", "Quad Stretch", "Side Bend Stretch", "Traditional Shoulder Stretch", "Tricep Stretch", "Pole Shoulder Stretch", "Back Stretch", "Chest Stretch", "Hamstring Stretch"]]
    
    
    let presetWorkouts : NSDictionary = ["Greenie Parent": ["Criss Cross Touches","Torso Rotations", "Alternating High Knee Kick","Leg Swings Left","Leg Swings Right","Jumping Jacks","Squat Kicks","Traveling Push Up","Criss Cross Crunch","Toe Jacks","Shoulder Rolls","Arm Pulls","Toe Touch Stretch","Quad Stretch","Fluid Warrior","Down Dog","Child's Pose","Calf Stretch","Cobra","Glute Stretch Left","Glute Stretch Right", "Side Stretch Left", "Side Stretch Right"], "Wounded Parent" : ["Arm Cross Swings", "Torso Circles","Torso Rotations", "Marching", "Walking Boxer Shuffle", "Knee Plank Touch Down", "Double Squat Pull", "Reverse Lunge", "Back Bow", "Knee Push Up","Bent Over Fly", "Cross Knee Pull", "Toe Touch Kicks", "Lateral Step", "3 Punches + 2 Knees","Walk Downs", "Step Up With Knee Pull", "Toe Touches","Quad Stretch", "Calf Stretch", "Down Dog", "Cobra", "Child's Pose"]]
    
    func setup() -> [WorkoutCategory]{
        
        var arr : [WorkoutCategory] = []
        
        //Warmups at top and cool downs at bottom
        
        
        var orderedList = ["Warmups","Upper Body","Lower Body","Core","Cardio/Plyometrics","Cool Downs/Stretches"]
        
        
        for i in 0...orderedList.count - 1 {
            let current : [String] = cats[orderedList[i]]!
            let n = WorkoutCategory()
            n.categoryName = orderedList[i]
            for name in current {
                let w = Workout()
                w.name = name
                n.exercises.append(w)
            }
            arr.append(n)
        }
        
        
        return arr
    }
    
}
