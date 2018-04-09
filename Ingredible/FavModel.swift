//
//  FavModel.swift
//  Ingredible
//
//  Created by Chloe Johnson on 4/6/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import Foundation

class FavModel {
    
    static var title: String = ""
    static var ingredinets: NSArray! = []
    
    //currently selected recipe
    static var currentSelection:String = ""
    
    //list of favorited recipes
    static var favorites = [String]()
    
    //list of all recipes displayed
    static var allRecipes = [NSDictionary]()
    
    //list of all matched recipe titles
    static var allTitles = [String]()
    
    //list of selected ingredients
    static var selectedIng = [String]()
}
