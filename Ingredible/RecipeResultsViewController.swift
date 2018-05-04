//
//  RecipeResultsViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.

import UIKit
import Firebase

class RecipeResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase setup
        ref = Database.database().reference()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.hidesBackButton = true
        
        fetchRecipes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // provide an alert if the recipe search did not yield any recipes
        if FavModel.allRecipes.isEmpty {
            let alert = UIAlertController(title: "Your search did not yield any recipes.", message: "Try adding more ingredients to your search. Make sure you include common items like salt and pepper.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                if self.presentingViewController is UITabBarController{
                    self.dismiss(animated: true, completion: nil)
                }else if let owningNavController = self.navigationController{
                    owningNavController.popViewController(animated: true)
                }else{
                    fatalError("view is not contained by a navigation controller")
                }
            }))
            self.present(alert, animated: true)
        }
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
                    
                    let meal = recipe?["Meal"] as! String
                    
                    let vegan = recipe?["Vegan"] as! Bool
                    let vegetarian = recipe?["Vegetarian"] as! Bool
                    
                    
                    let selectedIngredientsNSSet = NSSet(array: FavModel.selectedIng)
                    let ingredientsNSSet = NSSet(array: ingredients as! [Any])
                    let matches = ingredientsNSSet.isSubset(of: selectedIngredientsNSSet as! Set<AnyHashable>)
                    
                    //if the selected ingredients match the recipe ingredients
                    if matches {
                        // if the selected meal type matches the recipe meal type
                        if meal == FavModel.mealType || FavModel.mealType == "All" || FavModel.mealType == "" {
                            //if vegetarian switch on, find only vegetarian recipes
                            if FavModel.vegetarianSwitch {
                                if vegetarian {
                                    itemSelected = true
                                }
                                else {
                                    itemSelected = false
                                }
                            }
                            // if vegan switch on, find only vegan recipes
                            if FavModel.veganSwitch {
                                if vegan {
                                    itemSelected = true
                                }
                                else {
                                    itemSelected = false
                                }
                            }
                        }
                        else {
                            itemSelected = false
                        }
                    }
                    else {
                        itemSelected = false
                    }
                    
                    if itemSelected{
                        self.count += 1
                        FavModel.allRecipes.append(recipe!)
                        FavModel.allTitles.append(title)
                    }
                    
                } //end of loop
                //Takes care of firebase asynchronicity
                DispatchQueue.main.async {self.tableView.reloadData()}
            }
        })
    }
    
    // Returns the same number of cells as recipes in our list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavModel.allTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) 
        cell.textLabel?.text = FavModel.allTitles[indexPath.item]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = FavModel.allRecipes[indexPath.row]
        
        let recTitle = value["Title"]
        let recServings = value["Servings"]
        let recQuantity = value["Quantity"]
        let recProcedure = value["Procedure"]
        
        let recIngredients = value["Ingredients"]
        let recMeal = value["Meal"]
        let recVegan = value["Vegan"]
        let recVegetarian = value["Vegetarian"]
        
        RecipeModel.procedure = recProcedure as! String
        RecipeModel.quantity = recQuantity as! [String]
        RecipeModel.servings = recServings as! String
        RecipeModel.title = recTitle as! String
        
        RecipeModel.ingredients = recIngredients as! [String]
        RecipeModel.meal = recMeal as! String
        RecipeModel.vegan = recVegan as! Bool
        RecipeModel.vegetarian = recVegetarian as! Bool
        
        performSegue(withIdentifier: "showRecipeDetail", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Swipe right to go back
    @IBAction func swipeRight(_ sender: Any) {
        if presentingViewController is UITabBarController{
            dismiss(animated: true, completion: nil)
        }else if let owningNavController = navigationController{
            owningNavController.popViewController(animated: true)
        }else{
            fatalError("view is not contained by a navigation controller")
        }
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
}
