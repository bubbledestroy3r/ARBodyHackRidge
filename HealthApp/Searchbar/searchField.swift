//
//  searchField.swift
//  HealthApp
//
//  Created by Noah Cooper on 3/3/18.
//  Copyright © 2018 Ugo Corp. All rights reserved.
//

import UIKit
import CoreData


class searchField : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {
    var species = ["Apple - 95","Banana - 105","Pear - 102","Hamburger - 298","Grilled Chesse - 291", "White Bread - 69", "Wheat Bread - 24", "Egg - 78", "Cheese - 113", "Hot Dog - 269", "Pizza Slice - 320", "Chocolate Bar - 274", "Bag of Chips - 424", "Muffin - 288", "Bagel - 100", "Cereal - 148", "Milk - 62", "Orange - 62", "Chocolate Milk - 100", "Water - 0", "French Toast - 264", "Pancakes - 175", "Crepes - 112", "Oatmeal - 158", "English Muffin - 134", "Donut - 303", "Crossaint -  231", "Rice - 216", "Beans - 648", "Peanut Butter - 200", "Almonds - 529", "Raisins - 129", "Cranberry - 123", "Strawberry - 47", "Clementine - 47", "Mango - 201", "Blackberry - 62", "Celery - 16", "Pasta - 369", "Macaroni and Cheese - 199", "Beef Taco - 190", "Mozzerela Sticks - 101", "Onion Rings - 480", "Chocolate Chip Cookie - 480", "Teriyaki Chicken - 130", "Caesar Salad - 151", "Ice Cream - 237", "Steak - 128", "Chicken Nuggets - 260", "French Fries - 365", "Brownies - 112", "Pie - 296", "Cheez-Its - 312", "Nachos - 787", "Hot Pretzel - 139", "Kiwi - 42", "Wings - 343", "Beer 154", "Soda - 251", "Diet Soda - 4", "Coke - 251", "Diet Coke - 4", "Sushi - 60", "Falafel - 333", "Hummus - 409", "Guacamole - 50", "Tomato - 22", "Broccoli - 35", "Lettuce - 53", "Egg Roll - 189", "Carrot - 21", "Cheesecake - 257", "Spinach 79", "Black Coffee - 2", "Tea - 2", "Juice - 120", "Bacon - 548", "Sausage - 297", "Lasagna - 366", "Gravy - 27", "Pudding - 143", "Porridge - 213", "Chicken Noodle Soup - 124", "Seaweed - 1", "Papaya - 62", "Cherries - 5", "Raspberry - 1", "Plums - 30", "Sauerkraut - 26", "Matzah - 56", "Lemon - 24", "Blueberry - 10", "Cucumber - 30", "Chicken Satay - 417", "Ham - 186", "Jelly - 56", "Jell-O - 84", "Cream Cheese - 102", "Yogurt - 107", "Ketchup 67", "Mayo - 59", "Barbeque Sauce - 66", "Soy Sauce - 124", "Curry Sauce - 32", "Peppers - 56", "Almond Milk - 99", "Soy Milk - 204", "Pop-Tarts - 86", "Watermelon - 60", "Melon - 160", "Oreo Cookies -20", "Crackers - 196", "Polenta - 187", "Canteloupe - 165", "Pita Bread - 245", "Brisket - 193", "Barley - 111", "Quinoa - 63", "Nerds Candy - 210", "Kit Kat - 236", "M & M - 279", "Snickers - 243", "Mars - 264", "Milky Way - 200", "Nutella - 200"]
    var calories = [95,105,102,298,291, 24, 69, 78, 113, 269, 320, 482, 274, 424, 288, 100, 148, 62, 208, 0, 264, 175, 112, 158, 134, 303, 231, 216, 648, 200, 529, 129, 123, 47, 47, 201, 62, 16, 369, 199, 190, 101, 480, 48, 130, 151, 137, 128, 260, 365, 112, 296, 312, 787, 139, 42, 43, 154, 251, 4, 251, 4, 60, 333, 409, 50, 22, 35, 53, 189, 21, 257, 79, 2, 2, 120, 548, 297, 166, 27, 143, 213, 124, 1, 62, 5, 1, 30, 26, 56, 24, 1, 30, 417, 186, 56, 84, 102, 107, 67, 59, 66, 124, 32, 56, 99, 204, 86, 60, 160, 20, 196, 187, 165, 245, 193, 111, 63, 210, 236, 279, 243, 264, 200]
    
    
   
    var speciesSearchResults: [String]?
    let searchController = UISearchController(searchResultsController: nil)
    
    let date = Date()
    let formatter = DateFormatter()
    var result = String()
    
    
    


    
    
    override func viewDidLoad() {
        speciesSearchResults = species
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        formatter.dateFormat = "MM.dd.yyyy"
        result = formatter.string(from: date)
        
        super.viewDidLoad()
        
       
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let species = speciesSearchResults else {
            return 0
        }
        return species.count
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        if self.species.count == 0 {
            self.speciesSearchResults = nil
            return
        }
        self.speciesSearchResults = self.species.filter({( aSpecies: String) -> Bool in
            // to start, let's just search by name
            return aSpecies.lowercased().range(of: searchText.lowercased()) != nil
        })
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView!.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        
       if let species = speciesSearchResults
       {
        let specie = species[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.thin)
        cell.textLabel?.text = "\(specie) Calories"
        
        }

        // Configure the cell...

        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            speciesSearchResults = species.filter { team in
                return team.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            speciesSearchResults = species
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView!.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        searchController.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Food Log Entry", message: "Do you wish to enter \(species[indexPath.row]) Calories to your food log?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(noAction)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (Void) in
           
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let m = Meal(context: context)
            m.meals = ("\(self.species[indexPath.row]) Calories - \(self.result)") as String
            
           
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            print("saved")
            
            self.performSegue(withIdentifier: "toList", sender: self)
        }
        alert.addAction(yesAction)
       
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func custom(_ sender: Any) {
        let alert = UIAlertController(title: "Food Log Entry", message: "Add an entry to your food log", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let action = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            let textField1 = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let m = Meal(context: context)
            m.meals = ("\(textField1.text!) - \(textField2.text!) Calories - \(self.result)")
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            print("saved")
            
            self.performSegue(withIdentifier: "toList", sender: self)
        }
        alert.addTextField { (textField1) in
            textField1.placeholder = "Enter food item"
        }
        alert.addTextField { (textField2) in
            textField2.placeholder = "Enter calorie amount"
        }
        alert.addAction(noAction)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.performSegue(withIdentifier: "toList", sender: self)
    }
    
    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
