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
    
    override func viewDidAppear(_ animated: Bool) {
        // if there are no favorite recipes, then provide user with an alert message
        if FavModel.favorites.isEmpty {
            let alert = UIAlertController(title: "You currently do not have any favorited recipes.", message: "Tap over to the home screen and 'Start cooking' to find and favorite a new recipe.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if(defaults.object(forKey: "Favorites") != nil) {
            let favoritesDict = defaults.object(forKey: "Favorites") as! [String : [String : Any]]
            FavModel.favorites = favoritesDict
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Returns the same number of cells as recipes in our list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        cell.textLabel?.font = UIFont(name:"Avenir", size:18)
        let dicTitle = Array(FavModel.favorites.keys).sorted()
        cell.textLabel?.text = dicTitle[indexPath.item]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    // if a favorited recipe has been selected, then go to the favorite recipe detail VC
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
