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
        let dicTitle = Array(FavModel.favorites.keys)
        cell.textLabel?.text = dicTitle[indexPath.item]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dicTitle = Array(FavModel.favorites.keys)
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
