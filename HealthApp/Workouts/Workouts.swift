//
//  Workouts.swift
//  WorkoutTracker
//
//  Created by David & Isabelle on 3/3/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit
import CoreData

class Workouts: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menu: UIVisualEffectView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutText: UITextView!
    
    @IBOutlet weak var activityDurationLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var workouts: [Workout] = []
    var stringManager :  [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        for i in workouts
        {
            let date = i.dateOfficial
            stringManager.insert(date! + " --- \(String(Double(i.totalTime))) seconds", at: 0)
        }
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for i in workouts {
            context.delete(i)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //Menu
        self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
        
        //About
        aboutText.text = "This app was made by Jake, Noah, and Ugo, three programmers who have previously won the Huskie Hack.\nThey made this app for Hack Ridge, another hackathon they attended after the Huskie Hack.\nThis app was meant to help people track their fitness and help them be healthy by tracking their daily steps, flights climbed, distance traveled, calories burnt, and calorie intake. This app also helps keep healthy by tracking workouts such as runs and walks."
        
        //Workouts
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Workouts
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //let workouts = self.workouts[indexPath.row]
        
        /*let dateObj = workouts.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateString = "Unresolved Date"
        if workouts.date == nil {
            print("no value")
        }
        else {
            let dateString = dateFormatter.string(from: dateObj!)
        }*/
        
        //let dateObj2 = task.endDate
        //let dateFormatter2 = DateFormatter()
        //dateFormatter2.dateFormat = "hh:mm a"
        //let dateString2 = dateFormatter.string(from: dateObj2!)
        //let addon = " - " + String((Double(workout.totalTime) / workout.speed)) + " meters"
        cell.textLabel?.text = stringManager[indexPath.row]
        /*let med = meds[indexPath.row]
         let dateObj2 = med.adminTiming
         let dateFormatter2 = DateFormatter()
         dateFormatter.dateFormat = "hh:mm a"
         let dateString2 = dateFormatter2.string(from: dateObj2!)
         cell.textLabel?.text = "💊 Take \(med.medName!) at \(dateString2)"*/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var workouts2 : [Workout] = []
        for i in workouts {
            workouts2.insert(i, at: 0)
        }
        let workout = workouts2[indexPath.row]
        
        stepsLabel.text! = "Steps - " + String(workout.stepCount)
        distanceLabel.text! = "Distance - " + String((round(Double(workout.totalTime) / workout.speed)*1000)/10000) + " meters"
        paceLabel.text! = "Pace - " + String(round(Double(workout.speed)*1000)/1000) + " m/s"
        let activityAddON = " min " + String(workout.totalTime % 60) + " s"
        activityDurationLabel.text! = "Activity Duration - " + String(Int(Double(workout.totalTime) / 60.0)) + activityAddON
        var calories = 0
        if workout.speed >= 4.47 {
            calories = Int(Double(workout.totalTime) * 0.115)
        }
        else if workout.speed >= 3.35 {
            calories = Int(Double(workout.totalTime) * 0.095)
        }
        else if workout.speed >= 2.98 {
            calories = Int(Double(workout.totalTime) * 0.087)
        }
        else if workout.speed >= 1.788 {
            calories = Int(Double(workout.totalTime) * 0.075)
        }
        else {
            calories = Int(Double(workout.totalTime) * 0.06667)
        }
        calorieLabel.text! = "Calories Burnt - " + String(calories)
        
        /*let dateObj = workouts.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"*/
        /*let dateString = "Unresolved Date"
        if workouts.date == nil {
            print("no value")
        }
        else {
            let dateString = dateFormatter.string(from: dateObj!)
        }*/
        
        //let dateObj2 = task.endDate
        //let dateFormatter2 = DateFormatter()
        //dateFormatter2.dateFormat = "hh:mm a"
        //let dateString2 = dateFormatter.string(from: dateObj2!)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (workouts.count)
    }
    
   
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if(editingStyle == .delete)
        {
            var workouts = self.workouts[indexPath.row]
            context.delete(workouts)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                workouts = try context.fetch(Workout.fetchRequest())
            }
            catch {
                print("Fetching failed")
            }
        }
        tableView.reloadData()
    }*/
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            workouts = try context.fetch(Workout.fetchRequest())
        }
        catch {
            print("Fetching failed")
        }
        
    }
    
    //Menu Slide In
    @IBAction func slideIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func slideInSwipe(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    //Menu Slide Out
    @IBAction func slideOut(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func slideOutSwipe(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func slideOutTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    
    //About
    @IBAction func aboutSlideOut(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func aboutSlide(_ sender: UIButton) {
        if (aboutView.frame.origin.x == -307) {
            UIView.animate(withDuration: 0.5, animations: {
                self.aboutView.frame = CGRect(x: 0, y: 0, width: 307, height: 681)
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
            })
        }
    }
    @IBAction func aboutSlideOutSwipe(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func aboutSlideInSwipe(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.aboutView.frame = CGRect(x: 0, y: 0, width: 307, height: 681)
        })
    }

}
