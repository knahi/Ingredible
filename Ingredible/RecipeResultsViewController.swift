//
//  RecipeResultsViewController.swift
//  Ingredible
//
//  Created by Chloe Johnson on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//  HUGE thanks to https://www.youtube.com/watch?v=tv5c1mZttVE

import UIKit
import Firebase

class RecipeResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //Firebase setup
        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRecipes()
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
    
    // Returns the same number of cells as recipes in our list
    // override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavModel.allTitles.count
    }
    
    // override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = FavModel.allTitles[indexPath.item]
        print(FavModel.allTitles[indexPath.item])
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Temporary back button
    // Takes you back to home screen
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToIngredients", sender: self)
    }

}
