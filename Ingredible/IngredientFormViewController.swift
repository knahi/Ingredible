//
//  IngredientFormViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//
// References: https://www.youtube.com/watch?v=VKnrx5Feapc, https://www.youtube.com/watch?v=5MZ-WJuSdpg, https://stackoverflow.com/questions/41737562/how-to-add-checkmark-tableview-multiple-swift-3-0

// Things to try later: https://www.youtube.com/watch?v=Q8k9E1gQ_qg

import UIKit
import Firebase

class IngredientFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mealType: UISegmentedControl!
    @IBOutlet weak var vegetarian: UISwitch!
    @IBOutlet weak var vegan: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    var mealTypeString = "Breakfast"
    var vegetarianBool = false
    var veganBool =  false
    var selectedIndexPathArray = Array<NSIndexPath>()
    var selectedIngredients = Array<String>()
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var count: Int = 0
    
    
    let foodCategories = ["Grains", "Fruits", "Vegetables", "Proteins", "Dairy", "Sweets/Fats", "Seasoning"]
    let ingredients = [
        // Grains
        ["Barley", "Bread", "Bulgur", "Couscous", "Farro", "Oats","Pasta", "Quinoa", "Rice", "Tortillas"],
        // Fruits
        ["Apples", "Bananas", "Blackberries", "Blueberries", "Cantaloupe", "Cherries", "Grapefruit", "Grapes", "Lemons", "Limes", "Nectarines", "Oranges", "Peaches", "Pears", "Pineapples", "Plums", "Raspberries", "Strawberries", "Watermelon"],
        // Vegetables
        ["Asparagus", "Avocados","Bell peppers", "Broccoli", "Cabbage", "Carrots", "Cauliflower", "Celery", "Corn", "Cucumbers",  "Garlic", "Green beans", "Green onions", "Hot peppers", "Lettuce", "Mushrooms", "Onions", "Potatoes", "Spaghetti squash", "Spinach", "Sweet potatoes", "Tomatoes"],
        // Proteins
        ["Beef", "Chicken", "Duck", "Eggs", "Lamb", "Legumes", "Pork", "Seafood"],
        // Dairy
        ["Butter", "Cheese", "Condensed milk", "Cream", "Cream cheese", "Milk", "Sour cream", "Yogurt"],
        // Sweets/Fats
        ["Brown sugar", "Chocolate", "Peanut butter", "Vegetable oil", "White sugar"],
        // Seasoning
        ["Almond extract", "Basil", "Bay leaves", "Cayenne pepper", "Cilantro", "Cinnamon", "Cumin", "Curry powder", "Garlic powder", "Hot sauce", "Nutmeg", "Onion powder", "Paprika", "Pepper", "Rosemary", "Salt", "Sugar", "Thyme", "Vanilla extract"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //Firebase setup
        ref = Database.database().reference()
    }
    
    @IBAction func mealType(_ sender: AnyObject) {
        switch mealType.selectedSegmentIndex
        {
        case 0:
            mealTypeString = "Breakfast";
        case 1:
            mealTypeString = "Lunch";
        case 2:
            mealTypeString = "Dinner";
        case 3:
            mealTypeString = "Dessert";
        case 4:
            mealTypeString = "Snack";
        default:
            break
        }
    }
    
    
    // Handles toggling of vegetarian switch
    @IBAction func vegetarianToggled(_ sender: UISwitch) {
        if vegetarian.isOn {
            vegetarianBool = true
        } else {
            vegetarianBool = false
        }
    }
    
    // Handles toggling of vegan switch
    @IBAction func veganToggled(_ sender: UISwitch) {
        if vegan.isOn {
            veganBool = true
        } else {
            veganBool = false
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Back button to tab bar controller
    @IBAction func backButton(_ segue: UITabBarController) {
        
    }
    
    // Button to recipe results view controller
    @IBAction func getRecipesButton(_ sender: Any) {
        //fetchRecipes()
        FavModel.selectedIng = selectedIngredients
        print(FavModel.selectedIng)
        performSegue(withIdentifier: "ingredientsToRecipes", sender: self)
    }

    func fetchRecipes(){
        self.count = 0
        FavModel.allRecipes = [NSDictionary]()
        FavModel.allTitles = [String]()
        ref.child("Recipes").observe(.value, with:{ (snapshot) in
            // if it doesn't return null
            if let collection = snapshot.value as? NSDictionary {
                for item in collection{
                    var itemSelected:Bool = true
                    
                    let recipe = item.value as? NSDictionary
                    
                    let ingredients = recipe?["Ingredients"] as! NSArray
                    let title = recipe?["Title"] as! String
                    
                    let selectedIngredientsNSSet = NSSet(array: FavModel.selectedIng)
                    let ingredientsNSSet = NSSet(array: ingredients as! [Any])
                    let matches = ingredientsNSSet.isSubset(of: selectedIngredientsNSSet as! Set<AnyHashable>)
                    
                    if matches {
                        itemSelected = true
                    }
                    else {
                        itemSelected = false
                    }
                    
                    if itemSelected{
                        self.count += 1
                        FavModel.allRecipes.append(recipe!)
                        FavModel.allTitles.append(title)
                    }
                    
                    //print (ingredients[0])
                    //print (ingredients.count)
                    //print(recipe!)
                } //end of loop
                //print(FavModel.allRecipes)
                //print(FavModel.allTitles)
                
                //Takes care of firebase asynchronicity
                DispatchQueue.main.async {self.tableView.reloadData()}
            }
        })
    }

}


