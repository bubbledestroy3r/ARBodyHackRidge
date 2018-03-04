//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by David & Isabelle on 3/3/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit
import CoreMotion

class WorkoutTracker: UIViewController {

    @IBOutlet var workoutSaved: UILabel!
    @IBOutlet weak var menu: UIVisualEffectView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutText: UITextView!
    
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var tenMinuteProgress: UIProgressView!
    @IBOutlet weak var tenMinuteProgressCircle: KDCircularProgress!
    
    var pedometer = CMPedometer()
    
    var numberOfSteps:Int! = nil
    var distance:Double! = nil
    var pace:Double! = nil
    var averagePace:Double! = nil
    
    var timer = Timer()
    let timerInterval = 1.0
    var timeElapsed:TimeInterval = 0.0
    
    override func viewDidLoad() {
        workoutSaved.isHidden = true
        super.viewDidLoad()
        //Menu
        self.menu.frame = CGRect(x: -414, y: 0, width: 414, height: 736)
        
    
        
        //About
        aboutText.text = "This app was made by Jake, Noah, and Ugo, three programmers who have previously won the Huskie Hack.\nThey made this app for Hack Ridge, another hackathon they attended after the Huskie Hack.\nThis app was meant to help people track their fitness and help them be healthy by tracking their daily steps, flights climbed, distance traveled, calories burnt, and calorie intake. This app also helps keep healthy by tracking workouts such as runs and walks."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Start/Stop Workout
    @IBAction func startStopButton(_ sender: Any) {
        if startStopButton.titleLabel?.text == "Start" {
            startStopButton.setTitle("Stop", for: .normal)
            pedometer = CMPedometer()
            startTimer()
            pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                if let pedData = pedometerData{
                    self.numberOfSteps = Int(pedData.numberOfSteps)
                    //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                    if let distance = (pedData.distance) {
                        self.distance = Double(round(1000*Double(distance))) / 10000
                    }
                    if let averageActivePace = pedData.averageActivePace {
                        self.averagePace = Double(round(1000*Double(averageActivePace))) / 1000
                    }
                    if let currentPace = pedData.currentPace {
                        self.pace = Double(round(1000*Double(currentPace))) / 1000
                    }
                } else {
                    self.numberOfSteps = nil
                }
            })
        }
        else {
            startStopButton.setTitle("Start", for: .normal)
            stopTimer()
            pedometer.stopUpdates()
        }
    }
    
    //Conversions
    // convert seconds to hh:mm:ss as a string
    func timeIntervalFormat(interval:TimeInterval)-> String{
        var seconds = Int(interval + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }
    // convert a pace in meters per second to a string with
    // the metric m/s and the Imperial minutes per mile
    func paceString(title:String,pace:Double) -> String{
        var minPerMile = 0.0
        let factor = 26.8224 //conversion factor
        if pace != 0 {
            minPerMile = Double(round(factor / pace * 100)) / 100.0
        }
        let minutes = Int(minPerMile)
        let seconds = Int(minPerMile * 60) % 60
        return String(format: "%02.2f m/s",title,pace,minutes,seconds)
    }
    func AvgPace()-> Double {
        if let distance = self.distance{
            pace = distance / timeElapsed
            return pace
        } else {
            return 0.0
        }
    }
    func miles(meters:Double)-> Double{
        let mile = 0.000621371192
        return Double(round(meters * mile * 100)) / 100.0
    }
    
    //Timer
    func startTimer(){
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    func stopTimer(){
        timer.invalidate()
        displayPedometerData()
    }
    @objc func timerAction(timer:Timer){
        displayPedometerData()
    }
    func displayPedometerData(){
        timeElapsed += 1.0
        timeLabel.text = timeIntervalFormat(interval: timeElapsed)
        //Number of steps
        if let numberOfSteps = self.numberOfSteps{
            stepsLabel.text = String(format:"%i",numberOfSteps)
        }
        
        //distance
        if let distance = self.distance{
            distanceLabel.text = String(miles(meters: distance)) + " mi"
        } else {
            distanceLabel.text = "0 mi"
        }
        
        //average pace
        if let averagePace = self.averagePace{
            averagePaceLabel.text = String(averagePace) + " m/s"
        } else {
            averagePaceLabel.text =  String(AvgPace()) + " m/s"
        }
        
        //pace
        if let pace = self.pace {
            paceLabel.text = String(pace) + " m/s"
        } else {
            paceLabel.text =  String(AvgPace()) + " m/s"
        }
        
        //ten minute progress
        tenMinuteProgress.progress = Float(timeElapsed / 600)
        tenMinuteProgressCircle.angle = timeElapsed / 600 * 360
    }
    
    //Menu Slide In
    @IBAction func slideIn(_ sender: Any) {
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
    
    //Save Workout
    @IBAction func saveWorkout(_ sender: UIButton) {
        workoutSaved.alpha = 1
        workoutSaved.isHidden = false
        UIView.animate(withDuration: 6, animations: {
            self.workoutSaved.alpha = 0
        })
        let contextt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let workouts = Workout(context: contextt)
        workouts.speed = AvgPace()
        workouts.totalTime = Int16(timeElapsed)
        workouts.stepCount = Int16(stepsLabel.text!)!
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour,from: date)
        let minutes = calendar.component(.minute,from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        var officialDate = String(day) + "/" + String(month) + "/" + String(year)
        officialDate = officialDate + " "
        if hour < 10 {
            officialDate = officialDate + "0" + String(hour)
        }
        else {
            officialDate = officialDate + String(hour)
        }
        if minutes < 10 {
            officialDate = officialDate + ":" + String(minutes)
        }
        else {
            officialDate = officialDate + ":" + String(minutes)
        }
        workouts.dateOfficial = officialDate
        //workouts.calories =
        print("lit")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    //Reset
    @IBAction func reset(_ sender: UIButton) {
        startStopButton.setTitle("Start", for: .normal)
        stopTimer()
        timer.invalidate()
        pedometer.stopUpdates()
        
    }
}

