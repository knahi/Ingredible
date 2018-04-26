//
//  FavoritesViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/12/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var tableView: UITableView!
    let dicTitle = Array(FavModel.favorites.keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if(defaults.object(forKey: "Favorites") != nil) {
            var favoritesDict = defaults.object(forKey: "Favorites") as! [String : [String : Any]]
            FavModel.favorites = favoritesDict
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Returns the same number of cells as recipes in our list
    // override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavModel.favorites.count
    }
    
    // override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) 
        let dicTitle = Array(FavModel.favorites.keys).sorted()
        cell.textLabel?.text = dicTitle[indexPath.item]
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dicTitle = Array(FavModel.favorites.keys).sorted()
        let favName = dicTitle[indexPath.row]
        let value = FavModel.favorites[favName]
        
        let recTitle = value!["Title"]
        let recServings = value!["Servings"]
        let recQuantity = value!["Quantity"]
        let recProcedure = value!["Procedure"]
        
        RecipeModel.procedure = recProcedure as! String
        RecipeModel.quantity = recQuantity as! [String]
        RecipeModel.servings = recServings as! String
        RecipeModel.title = recTitle as! String
        
        performSegue(withIdentifier: "showFavoriteDetail", sender: self)
    }


}
