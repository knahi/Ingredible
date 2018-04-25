//
//  AddPantryViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/24/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class AddPantryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var currentlySelected: UILabel!
    @IBOutlet var scroller: UIScrollView!
    @IBOutlet var pantryTitle: UITextField!
    
    var selectedIndexPathArray = Array<NSIndexPath>()
    var selectedIngredients = Array<String>()
    var selectedPantry = Array<String>()
    var allIngredients = Array<String>()
    var uniqueIngredients = Array<String>()
    
    let foodCategories = ["Grains", "Fruits", "Vegetables", "Proteins", "Dairy", "Sweets/Fats", "Seasoning"]
    let ingredients = [
        // Grains
        ["Barley", "Bread", "Bread crumbs", "Bulgur", "Couscous", "Farro", "Flour", "Oats", "Pasta", "Quinoa", "Rice", "Tortillas"],
        // Fruits
        ["Apples", "Bananas", "Blackberries", "Blueberries", "Cantaloupe", "Cherries", "Grapefruit", "Grapes", "Lemons", "Limes", "Nectarines", "Oranges", "Peaches", "Pears", "Pineapples", "Plums", "Raspberries", "Strawberries", "Watermelon"],
        // Vegetables
        ["Asparagus", "Avocados", "Bell peppers", "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Celery", "Corn", "Cucumbers",  "Garlic", "Green beans", "Green onions", "Hot peppers", "Kale", "Lettuce", "Mushrooms", "Onions", "Peppers", "Potatoes", "Spaghetti squash", "Spinach", "Sweet potatoes", "Tomatoes"],
        // Proteins
        ["Beef", "Chicken", "Duck", "Eggs", "Fish", "Lamb", "Legumes", "Nuts", "Pork", "Shrimp", "Tofu"],
        // Dairy
        ["Butter", "Cheese", "Condensed milk", "Cream", "Cream cheese", "Milk", "Sour cream", "Yogurt"],
        // Sweets/Fats
        ["Brown sugar", "Chocolate", "Cocoa powder", "Coconut oil", "Confectioners' sugar", "Graham crackers", "Honey", "Maple syrup", "Marshmallows", "Olive oil", "Peanut butter", "Vegetable oil", "White sugar"],
        // Seasoning
        ["Almond extract", "Basil", "Bay leaves", "Cajun seasoning", "Cayenne pepper", "Chili powder", "Cilantro", "Cinnamon", "Cloves", "Cumin", "Curry powder", "Garlic powder", "Ginger", "Hot sauce", "Mustard", "Nutmeg", "Nutritional yeast", "Onion powder", "Paprika", "Pepper", "Red wine vinegar", "Rosemary", "Sage", "Salsa", "Salt", "Soy sauce", "Thyme", "Tomato paste", "Tomato sauce", "Turmeric", "Vanilla extract", "Vegetable broth", "Vegetable soup"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

    }
    
    //TableView Set-Up
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.foodCategories[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.foodCategories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients[section].count
    }


    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none {
            selectedIndexPathArray.append(indexPath as NSIndexPath)
            selectedIngredients.append(ingredients[indexPath.section][indexPath.row])
        }
        else{
            let i = selectedIngredients.index(of: ingredients[indexPath.section][indexPath.row]) as! Int
            selectedIndexPathArray.remove(at: i)
            selectedIngredients.remove(at: i)
        }
        tableView.reloadData()

        //Combine picker and table view ingredients
        allIngredients = selectedIngredients
        allIngredients.append(contentsOf: selectedPantry)
        uniqueIngredients = Array(Set(allIngredients))
        uniqueIngredients = uniqueIngredients.sorted()

        //Set label
        let stringText = uniqueIngredients.joined(separator: ", ")
        currentlySelected.text = stringText
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.section][indexPath.row]
        cell.accessoryType = .none
        for item in selectedIndexPathArray {
            if indexPath == item as IndexPath  {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    @IBAction func addPantry(_ sender: Any) {
        let title = pantryTitle.text
        PantriesModel.pantries[title!] = uniqueIngredients
        
        if presentingViewController is UITabBarController{
            dismiss(animated: true, completion: nil)
            
        }else if let owningNavController = navigationController{
            owningNavController.popViewController(animated: true)
        }else{
            fatalError("view is not contained by a navigation controller")
        }
        
        let defaults = UserDefaults.standard
        defaults.set(PantriesModel.pantries, forKey: "Pantries")
        defaults.synchronize()
        //print(defaults.object(forKey: "Pantries"))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if presentingViewController is UITabBarController{
            dismiss(animated: true, completion: nil)
            
        }else if let owningNavController = navigationController{
            owningNavController.popViewController(animated: true)
        }else{
            fatalError("view is not contained by a navigation controller")
        }
    }
}
