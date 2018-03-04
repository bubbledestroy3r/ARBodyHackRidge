//
//  addWaterViewController.swift
//  WaterTrack
//
//  Created by Jake Imyak on 3/4/18.
//  Copyright © 2018 Alright Devlopment. All rights reserved.
//

import UIKit

class addWaterViewController: UIViewController {

    @IBOutlet weak var amountOfWater: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addWater(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let wat = Entity(context: context)
        let amount = amountOfWater.text
        let intAmt: Int32 = Int32(amount!)!
        wat.amt = Int32(intAmt)
        print(wat.amt)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
