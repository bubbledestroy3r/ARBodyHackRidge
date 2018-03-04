//
//  ViewController.swift
//  HealthApp
//
//  Created by David & Isabelle on 3/3/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit
import HealthKit
import Foundation

class HomePage: UIViewController {
    
    var timer = Timer()
    
    //Menu
    @IBOutlet weak var menu: UIVisualEffectView!
    
    //Stats
    @IBOutlet weak var stepCount: KDCircularProgress!
    @IBOutlet weak var distanceTraveled: KDCircularProgress!
    @IBOutlet weak var floorCount: KDCircularProgress!
    @IBOutlet weak var calorieCount: KDCircularProgress!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var floorsLabel: UILabel!
    
    //HealthKit
    let healthStore = HKHealthStore()
    var steps = 0.0
    var distance = 0.0
    var floors = 0.0
    var calories = 0.0
    
    //About
    @IBOutlet weak var aboutText: UITextView!
    @IBOutlet weak var aboutView: UIView!
    
    
    
    override func viewDidLoad() {
         stepsLabel.text = "Loading"
         distanceLabel.text = "Loading"
        calorieLabel.text = "Loading"
        floorsLabel.text = "Loading"
        
        
        self.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
        
        self.recentSteps()
        
        
       
        
        super.viewDidLoad()
        //Menu
        self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
        
        //About
        aboutText.text = "This app was made by Jake, Noah, and Ugo, three programmers who have previously won the Huskie Hack.\nThey made this app for Hack Ridge, another hackathon they attended after the Huskie Hack.\nThis app was meant to help people track their fitness and help them be healthy by tracking their daily steps, flights climbed, distance traveled, calories burnt, and calorie intake. This app also helps keep healthy by tracking workouts such as runs and walks."
        
        
        updateProgressBars()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateProgressBars), userInfo: nil, repeats: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Menu Slide In
    @IBAction func slideIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: 0, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func slideInSwipe(_ sender: Any) {
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
    
    @IBAction func slideOutSwipe(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func slideOutTap(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    
    //About
    @IBAction func menuSlideOut(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func menuSlide(_ sender: UIButton) {
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
    @IBAction func aboutSlideOutSwipe(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.aboutView.frame = CGRect(x: -307, y: 0, width: 307, height: 681)
        })
    }
    @IBAction func aboutSlideInSwipe(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.aboutView.frame = CGRect(x: 0, y: 0, width: 307, height: 681)
        })
    }
    
    //HealthKit
    //Authorize
    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Swift.Void) {
        var isEnabled = true
        if HKHealthStore.isHealthDataAvailable() {
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            //let dataTypesToWrite = NSSet(object: stepsCount)
            //let dataTypesToRead = NSSet(object: stepsCount)
            healthStore.requestAuthorization(toShare: nil, read: stepsCount as? Set<HKObjectType>) { (success, error) -> Void in
                isEnabled = success
                print("success")
                
            }
        }
        else
        {
            isEnabled = false
        }
        
        
    }
    

    
    //Progress Bars
    @objc func updateProgressBars() {
    
    
        
        
        
        
    }

    func animateProgressBars() {
        stepCount.animate(toAngle: steps / 10000.0 * 360.0, duration: 2, completion: nil)
        distanceTraveled.animate(toAngle: steps / 2000.0 / 5.0 * 360.0, duration: 2, completion: nil)
        floorCount.animate(toAngle: floors / 250.0 * 360.0, duration: 2, completion: nil)
        calorieCount.animate(toAngle: calories / 1620 * 360, duration: 2, completion: nil)
    }
    
    func recentSteps()
    { // this function gives you all of the steps the user has taken since the beginning of the current day.
        
        // checkAuthorization just makes sure user is allowing us to access their health data.
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) // The type of data we are requesting
        
        
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let newDate = cal.startOfDay(for: date as Date)
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        
        // The actual HealthKit Query which will fetch all of the steps and add them up for us.
        let query = HKSampleQuery(sampleType: type!, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
            
            
            
            for result in results as! [HKQuantitySample]
            {
                self.steps += result.quantity.doubleValue(for: HKUnit.count())
                
            }
             DispatchQueue.main.async {
            print(self.steps)
            self.updateProgressBars()
            self.stepsLabel.text = String(Int(self.steps))
            //Distance
            self.distance = self.steps / 2000.0
            self.distanceLabel.text = String(Double(round(self.distance*1000)) / 1000.0) + " mi"
            
            //Floors
            
            
            
            //Calories
            self.calories = self.steps / 20.0
            self.calorieLabel.text = String(Int(self.calories))
                
            self.floors = self.calories * 0.17
            self.floorsLabel.text = String(Int(self.floors))
            
            self.animateProgressBars()
            }
           
            
        }
            
            
            self.healthStore.execute(query)
            
            
        }
        
    }
    
    



