//
//  FavModel.swift
//  Ingredible
//
//  Created by Chloe Johnson on 4/6/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import Foundation

// holds information related to favorited recipes and the user ingredient search specifications
class FavModel {
    
    // A string containing the currently selected recipe
    static var currentSelection:String = ""
    
    // A list of favorited recipes
    static var favorites = [String : [String : Any]]()
    
    // A list of favorited titles
    static var favTitles = [String]()
    
    // A list of all recipes displayed
    static var allRecipes = [NSDictionary]()
    
    // A list of all matched recipe titles
    static var allTitles = [String]()
    
    // A list of selected ingredients
    static var selectedIng = [String]()

    // A string containing the state of the meal type segmented control
    static var mealType = String()
    
    // A boolean related to the state of the vegetarian switch (on or off)
    static var vegetarianSwitch = Bool()
    
    // A boolean related to the state of the vegan switch (on or off)
    static var veganSwitch = Bool()

}
