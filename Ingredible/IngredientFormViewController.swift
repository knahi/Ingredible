//
//  IngredientFormViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit
import Firebase

class IngredientFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var mealType: UISegmentedControl!
    @IBOutlet weak var vegetarian: UISwitch!
    @IBOutlet weak var vegan: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var currentlySelected: UILabel!
    @IBOutlet var scroller: UIScrollView!
    
    var selectedIndexPathArray = Array<NSIndexPath>()
    var selectedIngredients = Array<String>()
    var selectedPantry = Array<String>()
    var allIngredients = Array<String>()
    var uniqueIngredients = Array<String>()
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var count: Int = 0
    
    // list of food categories
    let foodCategories = ["Grains", "Fruits", "Vegetables", "Proteins", "Dairy", "Sweets/Fats", "Seasoning"]
    // array of string arrays containing ingredients corresponding to each of the food categories
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
        
        // Reset the Fav Model
        FavModel.mealType = "All"
        FavModel.vegetarianSwitch = false
        FavModel.veganSwitch = false
        
        print("here")
        
        // set tableview border
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1).cgColor
        tableView.layer.borderWidth = 2.0
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Setup the pickerview border
        pickerView.layer.borderColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1).cgColor
        pickerView.layer.borderWidth = 2.0
        
        // Find the index of "No pantry" and set it as the default pick
        let defaultRowIndex = Array(PantriesModel.pantries.keys).sorted().index(of: "No pantry")
        pickerView.selectRow(defaultRowIndex!, inComponent: 0, animated: true)
        
        // Set font for meal type segmented control
        let attr = NSDictionary(object: UIFont(name: "Avenir", size: 12)!, forKey: NSAttributedStringKey.font as NSCopying)
        mealType.setTitleTextAttributes(attr as [NSObject : AnyObject], for: .normal)
        
        // Set font for back button
        backButton.setTitleTextAttributes([ NSAttributedStringKey.font: UIFont(name: "Avenir", size: 18)!], for: UIControlState.normal)
        
        // Set label for selected ingredients
        currentlySelected.text = "No ingredients currently selected."
        
        //Firebase setup
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerView.reloadAllComponents()
    }
    
    // The segmented control options
    @IBAction func mealType(_ sender: AnyObject) {
        switch mealType.selectedSegmentIndex
        {
        case 0:
            FavModel.mealType = "All";
        case 1:
            FavModel.mealType = "Breakfast";
        case 2:
            FavModel.mealType = "Lunch";
        case 3:
            FavModel.mealType = "Dinner";
        case 4:
            FavModel.mealType = "Dessert";
        case 5:
            FavModel.mealType = "Snack";
        default:
            break
        }
    }
    
    
    // Handles toggling of vegetarian switch
    @IBAction func vegetarianToggled(_ sender: UISwitch) {
        if vegetarian.isOn {
            FavModel.vegetarianSwitch = true
        } else {
            FavModel.vegetarianSwitch = false
        }
    }
    
    // Handles toggling of vegan switch
    @IBAction func veganToggled(_ sender: UISwitch) {
        if vegan.isOn {
            FavModel.veganSwitch = true
        } else {
            FavModel.veganSwitch = false
        }
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
        header.textLabel?.font = UIFont(name:"Avenir", size:16)
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
        
        // Combine picker and table view ingredients
        allIngredients = selectedIngredients
        if selectedPantry != [""] {
            allIngredients.append(contentsOf: selectedPantry)
        }
        uniqueIngredients = Array(Set(allIngredients))
        uniqueIngredients = uniqueIngredients.sorted()
        
        // Set label of all of the currently selected ingredients
        let stringText = uniqueIngredients.joined(separator: ", ")
        currentlySelected.text = stringText
        print(uniqueIngredients)
        if uniqueIngredients.isEmpty {
            currentlySelected.text = "No ingredients currently selected."
        }
        currentlySelected.font = UIFont(name:"Avenir", size: 16.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont(name:"Avenir", size:16)
        cell.tintColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1)
        cell.textLabel?.text = ingredients[indexPath.section][indexPath.row]
        // Handle checkmarks
        cell.accessoryType = .none
        for item in selectedIndexPathArray {
            if indexPath == item as IndexPath  {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Handle checkmarks
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    

    //PickerView Set-Up
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PantriesModel.pantries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let keys = Array(PantriesModel.pantries.keys).sorted()
        return keys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Avenir", size: 20)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = Array(PantriesModel.pantries.keys).sorted()[row]
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let keys = Array(PantriesModel.pantries.keys).sorted()
        let title = keys[row]
        let ing = PantriesModel.pantries[title]
        
        selectedPantry = [String]()
        for i in 0..<(ing!.count) {
            selectedPantry.append(ing![i])
        }
        
        //Combine picker and table view ingredients
        allIngredients = selectedIngredients
        //Protect against unwanted comma before ingredients
        if selectedPantry != [""] {
            allIngredients.append(contentsOf: selectedPantry)
        }
        uniqueIngredients = Array(Set(allIngredients))
        uniqueIngredients = uniqueIngredients.sorted()
        
        //Set label
        let stringText = uniqueIngredients.joined(separator: ", ")
        currentlySelected.text = stringText
        if uniqueIngredients.isEmpty {
            currentlySelected.text = "No ingredients currently selected."
        }
        currentlySelected.font = UIFont(name:"Avenir", size: 16.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Back button
    @IBAction func back(_ sender: UIBarButtonItem) {
        if presentingViewController is UITabBarController{
            dismiss(animated: true, completion: nil)
            
        }else if let owningNavController = navigationController{
            owningNavController.popViewController(animated: true)
        }else{
            fatalError("view is not contained by a navigation controller")
        }
    }
    
    // Button to recipe results view controller
    @IBAction func getRecipesButton(_ sender: Any) {
        FavModel.selectedIng = uniqueIngredients
        performSegue(withIdentifier: "ingredientsToRecipes", sender: self)
    }
}


