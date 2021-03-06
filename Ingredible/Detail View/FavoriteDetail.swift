//
//  FavoriteDetail.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/12/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class FavoriteDetail: UIViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var servings: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var procedure: UILabel!
    @IBOutlet var quantityScrollView: UIScrollView!
    @IBOutlet var procedureScrollView: UIScrollView!
    
    @IBOutlet var favoriteButton: UIBarButtonItem!
    var pressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 237/255, green: 243/255, blue: 234/255, alpha: 1)
        
        let quantityString = RecipeModel.quantity.joined(separator: "\n")
        
        recipeTitle.text = RecipeModel.title
        servings.text = RecipeModel.servings
        quantity.text = quantityString
        procedure.text = RecipeModel.procedure
       
        //Check if recipe is in the favorites dictionary
        if FavModel.favorites[RecipeModel.title] != nil {
            pressed = true
            favoriteButton.image = UIImage(named: "filled-in-star")        }
        
        // set font for back button
        backButton.setTitleTextAttributes([ NSAttributedStringKey.font: UIFont(name: "Avenir", size: 18)!], for: UIControlState.normal)
        
        // set quantity border
        quantityScrollView.layer.masksToBounds = true
        quantityScrollView.layer.borderColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1).cgColor
        quantityScrollView.layer.borderWidth = 2.0
        
        // set tableview border
        procedureScrollView.layer.masksToBounds = true
        procedureScrollView.layer.borderColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1).cgColor
        procedureScrollView.layer.borderWidth = 2.0
    }
    
    // Favoriting and unfavoriting a recipe
    @IBAction func favorite(_ sender: Any) {
        if !pressed {
            favoriteButton.image = UIImage(named: "filled-in-star")
            pressed = true
            
            //Add recipe to list of favoites
            FavModel.favorites[RecipeModel.title] = ["Title": RecipeModel.title, "Servings": RecipeModel.servings, "Quantity": RecipeModel.quantity, "Procedure": RecipeModel.procedure]
            
            // State saving when recipe is favorited
            let defaults = UserDefaults.standard
            defaults.set(FavModel.favorites, forKey: "Favorites")
            defaults.synchronize()
        } else {
            favoriteButton.image = UIImage(named: "empty-star")
            pressed = false
            
            //Remove recipe from list of favorites
            FavModel.favorites.removeValue(forKey: RecipeModel.title)
            
            // State saving when recipe is unfavorited
            let defaults = UserDefaults.standard
            defaults.set(FavModel.favorites, forKey: "Favorites")
            defaults.synchronize()
        }
        
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
