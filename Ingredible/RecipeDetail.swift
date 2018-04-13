//
//  RecipeDetail.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/9/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class RecipeDetail: UIViewController {

    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var servings: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var procedure: UILabel!
    
    @IBOutlet var favoriteButton: UIButton!
    var pressed = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quantityString = RecipeModel.quantity.joined(separator: "\n")
        
        recipeTitle.text = RecipeModel.title
        servings.text = RecipeModel.servings
        quantity.text = quantityString
        procedure.text = RecipeModel.procedure
        
        //Check if recipe is in the favorites dictionary
        if FavModel.favorites[RecipeModel.title] != nil {
            pressed = true
            let image = UIImage(named: "filled-in-star") as UIImage!
            favoriteButton.setImage(image, for: .normal)
        }
    }

    @IBAction func favorite(_ sender: Any) {
        if !pressed {
            let image = UIImage(named: "filled-in-star") as UIImage!
            favoriteButton.setImage(image, for: .normal)
            pressed = true
            
            //Add recipe to list of favoites
            FavModel.favorites[RecipeModel.title] = ["Title": RecipeModel.title, "Servings": RecipeModel.servings, "Quantity": RecipeModel.quantity, "Procedure": RecipeModel.procedure]
        } else {
            let image = UIImage(named: "empty-star") as UIImage!
            favoriteButton.setImage(image, for: .normal)
            pressed = false
            
            //Remove recipe from list of favorites
            FavModel.favorites.removeValue(forKey: RecipeModel.title)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToResults", sender: self)
    }
    
}
