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
        PantriesModel.pantries["Dining Hall"] = ["Apples", "Bananas", "Bell peppers", "Bread", "Broccoli", "Brown sugar", "Butter", "Carrots", "Cheese", "Chocolate", "Cinnamon", "Cream cheese", "Grapefruit", "Honey", "Hot sauce", "Jam", "Ketchup", "Lettuce", "Milk", "Mustard", "Olives", "Onions", "Oranges", "Peanut butter", "Pepper", "Quinoa", "Rice", "Salt", "Soy sauce", "Spinach", "Tofu", "Tomatoes", "Tortillas", "White sugar", "Yogurt"]
        PantriesModel.pantries["Fruit Basket"] = ["Apples", "Bananas", "Blueberries", "Cantaloupe", "Cherries", "Grapes", "Lemons", "Limes", "Oranges", "Pears", "Pineapples", "Raspberries", "Strawberries"]
        
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
