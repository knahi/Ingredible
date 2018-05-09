//
//  PantriesModel.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/13/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import Foundation

// holds information related to pantries
class PantriesModel {
    
    // A list of all pantries
    static var pantries = [String : [String]]()

    // A string containing the title of the pantry
    static var title: String = ""
    
    // A list of the names of ingredients in the pantry
    static var ingredients = [String]()
    
}
