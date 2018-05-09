//
//  RecipeModel.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/9/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import Foundation

// holds information related to each recipe
class RecipeModel {
    
    // A string containing the title of the recipe
    static var title: String = ""
    
    // A list of the quantity of ingredients required to make the recipe
    static var quantity = [String]()
    
    // A string containing the number of servings a recipe will make
    static var servings: String = ""
    
    // A string containing the steps required to make the recipe
    static var procedure: String = ""
    
    // A list of the names of the ingredients needed to make the recipe
    static var ingredients = [String]()
    
    // A string relating to the type of meal (e.g. breakfast)
    static var meal: String = ""
    
    // A boolean to convey if the recipe is vegan or not
    static var vegan: Bool = false
    
    // A boolean to convery if the recipe is vegetarian or not
    static var vegetarian: Bool = false
    
}
