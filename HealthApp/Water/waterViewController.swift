//
//  ViewController.swift
//  WaterTrack
//
//  Created by Jake Imyak on 3/4/18.
//  Copyright © 2018 Alright Devlopment. All rights reserved.
//

import UIKit

class waterViewController: UIViewController {
    var waters : [Entity] = []
    
    @IBOutlet weak var waterImage: UIImageView!
    @IBOutlet weak var waterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
        var x = 0
        for i in waters {
            x += Int(i.amt)
        }
        if(x < 2)
        {
            waterImage.image = #imageLiteral(resourceName: "Empty")
        }
        else if(x < 5)
        {
            waterImage.image = #imageLiteral(resourceName: "Quarter")
        }
        else if(x < 9)
        {
            waterImage.image = #imageLiteral(resourceName: "Half")
        }
        else if(x < 13) {
            waterImage.image = #imageLiteral(resourceName: "threeQuarters")
        }
        else
        {
            waterImage.image = #imageLiteral(resourceName: "Full")
        }
         waterLabel?.text = "\(x) ounces of water"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            waters = try context.fetch(Entity.fetchRequest())
        }
        catch {
            print("Fetching failed")
        }
        
    }
    
}
