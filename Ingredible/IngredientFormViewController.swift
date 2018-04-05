//
//  IngredientFormViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//
// References: https://www.youtube.com/watch?v=VKnrx5Feapc, https://www.youtube.com/watch?v=5MZ-WJuSdpg

// Things to try later: https://www.youtube.com/watch?v=Q8k9E1gQ_qg

import UIKit

class IngredientFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let foodCategories = ["Grains", "Fruits", "Vegetables", "Proteins", "Dairy", "Sweets/Fats", "Seasoning"]
    let ingredients = [
        // Grains
        ["Rice", "Quinoa", "Couscous", "Farro", "Oats", "Bulgur", "Barley", "Bread"],
        // Fruits
        ["Bananas", "Apples", "Grapes", "Strawberries", "Oranges", "Watermelon", "Lemons", "Blueberries", "Peaches", "Cantaloupe", "Pineapples", "Cherries", "Pears", "Limes", "Raspberries", "Blackberries", "Plums", "Nectarines", "Grapefruit"],
        // Vegetables
        ["Potatoes", "Tomatoes", "Onions", "Avocados", "Carrots", "Lettuce", "Broccoli", "Bell peppers", "Celery", "Cucumbers", "Corn", "Garlic", "Mushrooms", "Sweet potatoes", "Spinach", "Cabbage", "Green beans", "Hot peppers", "Cauliflower", "Green onions", "Asparagus"],
        // Proteins
        ["Seafood", "Eggs", "Pork", "Beef", "Chicken", "Duck", "Lamb", "Legumes"],
        // Dairy
        ["Butter", "Cheese", "Milk", "Cream", "Yogurt"],
        // Sweets/Fats
        ["Chocolate", "Oil"],
        // Seasoning
        ["Thyme", "Basil", "Rosemary", "Sugar", "Salt"]
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.foodCategories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.foodCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Back button to tab bar controller
    @IBAction func backButton(_ segue: UITabBarController) {
        
    }
    
    // Button to recipe results view controller
    @IBAction func getRecipesButton(_ sender: Any) {
        performSegue(withIdentifier: "ingredientsToRecipes", sender: self)
    }


}
