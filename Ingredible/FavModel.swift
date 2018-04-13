//
//  FavModel.swift
//  Ingredible
//
//  Created by Chloe Johnson on 4/6/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import Foundation

class FavModel {
    
    //currently selected recipe
    static var currentSelection:String = ""
    
    //list of favorited recipes
    static var favorites = [String : [String : Any]]()
    
    //list of favorited titles
    static var favTitles = [String]()
    
    //list of all recipes displayed
    static var allRecipes = [NSDictionary]()
    
    //list of all matched recipe titles
    static var allTitles = [String]()
    
    //list of selected ingredients
    static var selectedIng = [String]()
}
