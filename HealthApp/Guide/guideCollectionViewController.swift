//
//  guideCollectionViewController.swift
//  HealthApp
//
//  Created by Noah Cooper on 3/4/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class guideCollectionViewController: UICollectionViewController {
    @IBOutlet var navBar: UINavigationItem!
    
    var titles = ["Avocado", "Beans", "Oats", "Salmon", "Dark Chocolate", "Veggies", "Fruit", "Green Tea", "Swimming", "Biking", "Steps", "Running Uphill", "Weights", "Skiing"]
    var pictures = [#imageLiteral(resourceName: "avocado"), #imageLiteral(resourceName: "bean1"), #imageLiteral(resourceName: "oats"), #imageLiteral(resourceName: "salmon"), #imageLiteral(resourceName: "darkC"), #imageLiteral(resourceName: "veggies"), #imageLiteral(resourceName: "fruits"), #imageLiteral(resourceName: "greentea"), #imageLiteral(resourceName: "swimming"), #imageLiteral(resourceName: "woman-and-bicycle"), #imageLiteral(resourceName: "aerobic_steps_XL"), #imageLiteral(resourceName: "runningUphill"), #imageLiteral(resourceName: "free-weights") , #imageLiteral(resourceName: "ski")]
    var descriptions = ["Avocados are very good. Most people hear the word fat and will shy away but don't with Avocados! It iwll quiet hunger. As long as you stick in moderation with about half to a quater of an avocado per sitting you will get a meal filled with fiber and protein.","A single cup has 15 grams of protein. Beans lack of saturated fats thus making it a much healthier than red meat.","Oats fill you up due to the high fiber so you’re not snacking all day. It’s a healthy carb and it will boost your metabolism.","Salmon is a lean source of peotein without out adding pat. It's as a MUFA (healthy monounstatured fat) which is important to eat while trying to lose weight.", "Dark chocolate is a great substitute for anyone who is a chocolate lover. It's full of MUFA which again is great for losing weight. It will help your metabolism, cut fat, and burn calories.","Fiber and vitamin filled food that will bolster your weight loss journey. Most vegetables are very good for you so eating them will help. They will all help you in different ways so makes sure to have variety.","All fruits are very nutrient rich food that will fill you up and help you lose weights. Different fruits will help you in different ways but they will all help and get you nutrient but makes sure to have variety.", "Green tea is a great thing to drink while trying to lose weight. It has a ton of antioxidants to help burn fat and clories. Studies have shown that five cups a day may help you lose twice the amount.", "Can get your whole body involved using your arms in legs in all motions. One can burn up to 600 calories in an hour. It’s also very good for your joints because the buoyancy of the water helps reduce the stress on painful weight-bearing joints.","Depending on the speed at which you go, one could burn 500 to 1000 calories biking which is a lot in that amount of time. Also all you need is a bike or a stationary bike which is accessible to most.","Can lose up to 800 calories just by doing this exercise for an hour. It's a very simple workout and will really get you working!", "Burn 500 calories in a half hour doing this. Make sure you are going uphill so you work your leg muscles which is the largest muscles in the body. Also interval training will help you break sweat and get your muscles engaged!", "One’s heart rate will stay high which will burn calories! And your improving your physique by lifting weights so it’s a two for one!", "Skiing is not just a leisure sport, it is a great workout for the whole body. It is also a very fun experience to do with friends, and it makes cold winters much more enjoyable. Go out skiing if you have the chance because when summertime comes around, you will regret not going."]

    override func viewDidLoad() {
        
        let alert = UIAlertController(title: "Welcome to Your Personal Wellness Guide", message: "Tap on a picture for a physical wellness tip!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! guideCollectionViewCell
        cell.roundCorners()
        let tempImage = pictures[indexPath.row]
        
        cell.foodImg.image = tempImage
        
        
    
        // Configure the cell
    
        return cell
    }
    
  
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: titles[indexPath.row], message: descriptions[indexPath.row], preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
