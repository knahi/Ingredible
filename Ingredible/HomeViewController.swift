//
//  HomeViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/13/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Add default pantries
        PantriesModel.pantries["No pantry"] = [""]
        PantriesModel.pantries["Kitchen Classics"] = ["Bread", "Brown sugar", "Butter", "Eggs", "Flour", "Milk", "Peanut butter", "Pepper", "Salt", "Vegetable oil", "White sugar"]
        PantriesModel.pantries["Dining Hall"] = ["Apples", "Bananas", "Bell peppers", "Bread", "Broccoli", "Brown sugar", "Butter", "Carrots", "Cheese", "Chocolate", "Cinnamon", "Cream cheese", "Cucumbers", "Garlic powder", "Grapefruit", "Honey", "Hot sauce", "Jam", "Ketchup", "Lettuce", "Milk", "Mustard", "Nuts", "Olives", "Olive oil", "Onions", "Oranges", "Oregano", "Peanut butter", "Pepper", "Peppers", "Quinoa", "Red wine vinegar", "Rice", "Salt", "Soy sauce", "Spinach", "Tofu", "Tomatoes", "Tortillas", "White sugar", "Yogurt"]
        PantriesModel.pantries["Fruit Basket"] = ["Apples", "Bananas", "Blueberries", "Cantaloupe", "Cherries", "Grapes", "Lemons", "Limes", "Oranges", "Pears", "Pineapples", "Raspberries", "Strawberries"]
        PantriesModel.pantries["Get Recipes"] = ["Apples", "Avocados", "Bananas", "Bay leaves", "Bread", "Brown sugar", "Butter", "Cajun seasoning", "Cayenne pepper", "Cheese", "Chicken", "Chocolate", "Cinnamon", "Cloves", "Cocoa powder", "Coconut oil", "Condensed milk", "Couscous", "Cream", "Cumin", "Eggs", "Fish", "Garlic", "Garlic powder", "Ginger", "Graham crackers", "Honey", "Lemons", "Maple syrup", "Marshmallows", "Milk", "Mustard", "Olive oil", "Onions", "Onion powder", "Oranges", "Pasta", "Peanut butter", "Pepper", "Pork", "Quinoa", "Red wine vinegar", "Rice", "Salt", "Soy sauce", "Tomatoes", "Tomato paste", "Tomato sauce", "Tortillas", "Turmeric", "Vanilla extract", "Vegetable oil", "Vegetable soup", "White sugar"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
