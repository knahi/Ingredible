//
//  RecipeDetail.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/9/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class RecipeDetail: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var servings: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var procedure: UILabel!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var quantityScrollView: UIScrollView!
    @IBOutlet var procedureScrollView: UIScrollView!
    var pressed = false
    var popup:UIView!
    
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
            favoriteButton.image = UIImage(named: "filled-in-star")
        }
        
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
            
            // Alert view
            let alert = UIAlertController(title: "Recipe Favorited!", message: "Uncheck the star to remove recipe from favorite screen.", preferredStyle: .alert)
            
            // set font for alert
            let myTitle  = "Recipe Favorited!"
            let myMessage = "Uncheck the star to remove recipe from favorite screen."
            var myMutableStringTitle = NSMutableAttributedString()
            var myMutableStringMessage = NSMutableAttributedString()
            myMutableStringTitle = NSMutableAttributedString(string: myTitle as String, attributes: [NSAttributedStringKey.font:UIFont(name: "Avenir", size: 16.0)!])
            myMutableStringMessage = NSMutableAttributedString(string: myMessage as String, attributes: [NSAttributedStringKey.font:UIFont(name: "Avenir", size: 13.0)!])
            alert.setValue(myMutableStringTitle, forKey: "attributedTitle")
            alert.setValue(myMutableStringMessage, forKey: "attributedMessage")
            self.present(alert, animated: true, completion: nil)
            
            // Displays for 3 seconds that dismisses
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                alert.dismiss(animated: true, completion: nil)
            }
            
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
