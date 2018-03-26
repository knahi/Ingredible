//
//  IngredientFormViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class IngredientFormViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let foodCat = ["Grains", "Fruits", "Vegetables", "Proteins", "Dairy", "Sweets/Fats", "Seasoning"]
    let textCellIdentifier = "TextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCat.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = foodCat[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(foodCat[row])
    }
    
    // Back button to tab bar controller
    @IBAction func backButton(_ segue: UITabBarController) {
        
    }
    
    // Button to recipe results view controller
    @IBAction func getRecipesButton(_ sender: Any) {
        performSegue(withIdentifier: "ingredientsToRecipes", sender: self)
    }


}
